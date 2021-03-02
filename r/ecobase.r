#Import all the food webs you have. Maximise modularity by using the Leiden algorithm. Save the partitions in csv files. 

rm(list = ls()); cat("\014"); setwd('/Users/ema/Github/Data_aggregation/data/ewe_loopless')
library(leiden)
library(ggplot2)
library(tibble)
library(plyr)
library(igraph)
library(NetIndices)
library(dplyr)
library(RColorBrewer)
library(rnetcarto)

#DENSITY-BASED MODULARITY
file_list = list.files()
A_matrices = lapply(file_list, function(i){
  as.matrix(read.csv(i, header= FALSE))
  })

#G = matrix(list(), length(A_matrices),1)
#for (i in 1:length(G)){
#  G[[i]] = graph_from_adjacency_matrix(A_matrices[[i]], mode = "directed", weighted = "true", diag = TRUE)  
#}

#partition = matrix(list(), length(A_matrices),1)
#for (i in 1:length(G)){
#  partition[[i]] <- leiden(G[[i]])
#}

#for (i in 1:length(partition)){
#  name = paste("partition",file_list[[i]], sep="_")
#  write.table(partition[[i]],file = name, row.names = FALSE, col.names = FALSE, sep="\t")
#}

#PREY-BASED MODULARITY AND PREDATOR-BASED MODULARITY (the results doesn't contain all the nodes. This is because some nodes don't have preys and some don't have predators.)
A = A_matrices[[3]]
rownames(A) = 1:nrow(A) #Bug fix: it doesn't run if the rows and columns don't have a name.
colnames(A) = 1:nrow(A)
prey = netcarto(A, bipartite = TRUE)
df = data.frame(as.numeric(as.character(prey[[1]]$name)),as.numeric(as.character(prey[[1]]$module)))
colnames(df) = c("node","module")
df %>%
  arrange(node)
for (i in 1:ncol(A)){
  if (df$node[i] != i){
    df= rbind(df[1:i-1,], #Go from here. 
  }
}

colnames(df) = 
unlist()
prey = cbind(as.data.frame(prey[[1]]$name), prey[[1]]$module)

prey %>%
  summarise()
  

A = t(A)
predator = netcarto(A, bipartite = TRUE)
predator = cbind(as.data.frame(predator[[1]]$name), predator[[1]]$module)



































