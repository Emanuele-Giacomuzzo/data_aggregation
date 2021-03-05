rm(list = ls()); cat("\014"); setwd('/Users/ema/Github/Data_aggregation/r')
library(leiden)
library(ggplot2)
library(tibble)
library(plyr)
library(igraph)
library(NetIndices)
library(dplyr)
library(RColorBrewer)

#Create graph
edge_list <- read.delim('../data/Napoli/Edgelist_for_R.txt', header = FALSE)
links <- edge_list %>% select(V1,V2)
weights <- edge_list %>% select(V3)
G <- graph_from_edgelist(as.matrix(links)) #You need to invert i and j
E(G)$weight <- as.matrix(weights)
TP <- as.matrix(read.csv('../data/Napoli/results/TP.txt', header = FALSE))
V(G)$TP <- TP

#Plot graph
plotting_layout <- matrix( nrow=length(V(G)),ncol=2)
plotting_layout[,1] <- runif(length(V(G)))
plotting_layout[,2] <- TP[,1]
plot.igraph(simplify(G),
            #main= "Original food web",
            vertex.label=NA,
            vertex.size=2,
            vertex.color="grey75",
            #edge.width = E(G)$weight,
            edge.arrow.size=.25,
            layout=plotting_layout,
            axes=TRUE,
            xlim = c(0,1),
            ylim=c(0,3),
            ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

#Directed modularity
A <- get.adjacency(G,sparse=F) #Adjacency (i and j are inverted)
A <- t(A)
rownames(A) <- 1:nrow(A)
colnames(A) <- 1:nrow(A)
directed_modularity <- leiden(A)
node.cols <- brewer.pal(max(c(3, directed_modularity)),"Pastel1")[directed_modularity]
plot.igraph(simplify(G),
            #main= "Original food web",
            vertex.label=NA,
            vertex.size=2,
            vertex.color = node.cols,
            #edge.width = E(G)$weight,
            edge.arrow.size=.25,
            layout=plotting_layout,
            axes=TRUE,
            xlim = c(0,1),
            ylim=c(0,3),
            ylab="Trophic position (TP)",
            rescale=F,
            asp=0)
cat("There have been found", max(directed_modularity), "modules according to directed modularity (Arenas 2007).")

#Bipartite modularity (predators)
predator = netcarto(A, bipartite = TRUE)
predator = data.frame(as.numeric(as.character(predator[[1]]$name)),as.numeric(as.character(predator[[1]]$module))) #Node and module
colnames(predator) = c("node","module")
predator = predator %>%
    arrange(node)
predator[,2] = predator[,2]+1
predator_complete = data.frame(1:nrow(A),integer(nrow(A)))
colnames(predator_complete) = c("node","module")
max = max(predator$module)
for (i in 1:nrow(A)){
  row = which(predator$node == i)
  if (length(row) != 0){
    predator_complete$module[i] = predator$module[row]
    } else {
      predator_complete$module[i] = max+1
      max = max+1
    }
}


#Bipartite modularity (preys)
prey = netcarto(A, bipartite = TRUE)
prey = data.frame(as.numeric(as.character(prey[[1]]$name)),as.numeric(as.character(prey[[1]]$module))) #Node and module
colnames(prey) = c("node","module")
prey = prey %>%
  arrange(node)
prey[,2] = prey[,2]+1
prey_complete = data.frame(1:nrow(A),integer(nrow(A)))
colnames(prey_complete) = c("node","module")
max = max(prey$module)
for (i in 1:nrow(A)){
  row = which(prey$node == i)
  if (length(row) != 0){
    prey_complete$module[i] = prey$module[row]
  } else {
    prey_complete$module[i] = max+1
    max = max+1
  }
}

write.table(directed_modularity,file = "../data/Napoli/results/directed_modularity_Napoli.txt", row.names = FALSE, col.names = FALSE, sep="\t")
write.table(prey_complete[[2]],file = "../data/Napoli/results/prey_modularity_Napoli.txt", row.names=FALSE, col.names=FALSE, sep=",")
write.table(predator_complete[[2]],file = "../data/Napoli/results/predator_modularity_Napoli.txt", row.names=FALSE, col.names=FALSE, sep=",")