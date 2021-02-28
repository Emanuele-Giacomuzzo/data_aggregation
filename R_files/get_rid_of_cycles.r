#This piece of code gets rid of all the cycles (including self-loops) inside a food web. For now it gets rid of only the loops between two nodes.  
#Watch out: it might not find all the cycles.  
#It works only if you use a weighted network.
#Before running this code make sure to calculate the trophic position (or similar index) of the species inside the food web.

library(igraph)
library(plyr)
library(tidyr)
library(dplyr)
source("findCycles.r") 

#This part of the code imports multiple food webs all at once. Skip it if you are working with a single food web.
setwd('../data/ewe_networks') #Select the folder where the files are saved. 
temp <- list.files(pattern="edge_list.txt")
networks <- lapply(temp, read.delim)
temp <- list.files(pattern="TP.txt")
TP <- lapply(temp, read.delim)

for (n in 1:length(networks)){
  edge_list <- networks[[n]]
  TP <- TP [[n]]
  links <- edge_list %>% select(V1,V2)
  weights <- edge_list %>% select(V3)
  G <- graph_from_edgelist(as.matrix(links)) #You need to invert i and j
  E(G)$weight <- as.matrix(weights)
  V(G)$TP <- TP
  
  G <- simplify(G)
  Cycles <- findCycles(G)
  
  for (i in 1:length(Cycles)){
    loop <- unlist(Cycles[i], use.names=FALSE)
    if (length(loop) == 3) { #If the loop is between two nodes
      fromone <- get.edge.ids(G, c(loop[1],loop[2]), directed = TRUE, error = FALSE, multi = FALSE)  #Get the ID of an edge
      fromone <- edge_attr(G,"weight", index = fromone) #Get the weight of an edge
      fromtwo <- get.edge.ids(G, c(loop[2],loop[1]), directed = TRUE, error = FALSE, multi = FALSE)  #Get the ID of an edge
      fromtwo <- edge_attr(G,"weight", index = fromtwo) #Get the weight of an edge
      if (length(fromone)==1 & length(fromtwo)==1) {
        if (abs(TP[loop[1]]-TP[loop[2]])>0.2*max(TP)){ #If the TP of the two nodes is way different 
          if (TP[loop[1]]>TP[loop[2]]){
            G <- delete_edges(G,"loop[1]|loop[2]")
          } else {
            G <- delete_edges(G,"loop[2]|loop[1]")
          }
        } else { #If the TP of the two nodes is similar 
          if (fromone>fromtwo){
            edges_string_one <- paste(loop[2],loop[1], sep="|")
            G <- delete_edges(G,edges_string_one)
          } else {
            edges_string_two <- paste(loop[1],loop[2], sep="|")
            G <- delete_edges(G,edges_string_two)
          }
        }
      }
    }
  }
  
  loopless_edge_list <- cbind( get.edgelist(G) , E(G)$weight )
  file_name <- paste0("loopless",n,".txt")
  write.matrix( loopless_edge_list, file="file_name", sep = "\t" )
}