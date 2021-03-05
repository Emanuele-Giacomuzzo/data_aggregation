#Import all the food webs you have. 
#Maximise density-based, prey-based and predator-based modularity.
#Save the partitions in csv files. 

rm(list = ls()); cat("\014"); setwd('/Users/ema/Github/Data_aggregation/data/ecobase/A_loops')
library(leiden)
library(ggplot2)
library(tibble)
library(plyr)
library(igraph)
library(NetIndices)
library(dplyr)
library(RColorBrewer)
library(rnetcarto)

#IMPORT ADJACENCY MATRICES
file_list = list.files()
A_matrices = lapply(file_list, function(i){
  as.matrix(read.csv(i, header= FALSE))
  })

#COLUMNS AND ROWS NAMES (Bug fix: netcarto doesn't run if the rows and columns don't have a name)
for (i in 1:length(A_matrices)){
  rownames(A_matrices[[i]]) = 1:nrow(A_matrices[[i]])
  colnames(A_matrices[[i]]) = 1:nrow(A_matrices[[i]])
}

#DENSITY-BASED MODULARITY
G = matrix(list(), length(A_matrices),1)
density_based = matrix(list(), length(A_matrices),1)
for (i in 1:length(G)){
  G[[i]] = graph_from_adjacency_matrix(A_matrices[[i]], mode = "directed", weighted = "true", diag = TRUE)
  density_based[[i]] <- leiden(G[[i]])
}

#PREY-BASED MODULARITY
predator = matrix(list(), length(A_matrices),1)
predator_complete = matrix(list(), length(A_matrices),1)
for (n in 1:length(A_matrices)){
  A = A_matrices[[n]]
  
  predator[[n]] = netcarto(A, bipartite = TRUE)
  predator[[n]] = data.frame(as.numeric(as.character(predator[[n]][[1]]$name)),as.numeric(as.character(predator[[n]][[1]]$module))) #Node and module
  colnames(predator[[n]]) = c("node","module")
  predator[[n]] = predator[[n]] %>%
    arrange(node)
  predator[,2] = predator[,2]+1
  
  predator_complete[[n]] = data.frame(1:nrow(A),integer(nrow(A)))
  colnames(predator_complete[[n]]) = c("node","module")
  max = max(predator[[n]]$module)
  for (i in 1:nrow(A)){
    row = which(predator[[n]]$node == i)
    if (length(row) != 0){
      predator_complete[[n]]$module[i] = predator[[n]]$module[row] 
    } else {
      predator_complete[[n]]$module[i] = max+1
      max = max+1
    }
  }
}

#PREDATOR-BASED MODULARITY
prey = matrix(list(), length(A_matrices),1)
prey_complete = matrix(list(), length(A_matrices),1)
for (n in 1:length(A_matrices)){
  A = t(A_matrices[[n]])
  
  prey[[n]] = netcarto(A, bipartite = TRUE)
  prey[[n]] = data.frame(as.numeric(as.character(prey[[n]][[1]]$name)),as.numeric(as.character(prey[[n]][[1]]$module))) #Node and module
  colnames(prey[[n]]) = c("node","module")
  prey[[n]] = prey[[n]] %>%
    arrange(node)
  prey[,2] = prey[,2]+1
  
  prey_complete[[n]] = data.frame(1:nrow(A),integer(nrow(A)))
  colnames(prey_complete[[n]]) = c("node","module")
  max = max(prey[[n]]$module)
  for (i in 1:nrow(A)){
    row = which(prey[[n]]$node == i)
    if (length(row) != 0){
      prey_complete[[n]]$module[i] = prey[[n]]$module[row] 
    } else {
      prey_complete[[n]]$module[i] = max+1
      max = max+1
    }
  }
}

#WRITE
for (i in 1:length(A_matrices)){
  name = paste("density_modularity",file_list[[i]], sep="_")
  write.table(density_based[[i]],file = name, row.names = FALSE, col.names = FALSE, sep="\t")
  name = paste0("prey_modularity_",file_list[[i]])
  write.table(prey_complete[[i]][[2]],file = name, row.names=FALSE, col.names=FALSE, sep=",")
  name = paste0("predator_modularity_",file_list[[i]])
  write.table(predator_complete[[i]][[2]],file = name, row.names=FALSE, col.names=FALSE, sep=",")
}



































