#This code imports the food webs and finds the density-based, prey-based and predator-based modules.
#Then it produces vectors with inside the membership of different species to different modules and saves them into csv files.
rm(list = ls()); 
cat("\014"); 
setwd('/Users/ema/Github/Data_aggregation')

library(leiden)
library(ggplot2)
library(tibble)
library(plyr)
library(igraph)
library(NetIndices)
library(dplyr)
library(RColorBrewer)
library(rnetcarto)
source('r/findDensityModules.r')
source('r/findPredatorPreyModules.r')
source('r/addFrontZeros.r')

#IMPORT ADJACENCY MATRICES
setwd('data/adjacency_matrices')
files = list.files()
A_ecobase = lapply(files, function(web){
  as.matrix(read.csv(web, header= FALSE))
  })
setwd('../..')

#DENSITY-BASED MODULES
membership_density = matrix(list(), length(A_ecobase),1)
for (web in 1:length(A_ecobase)){
  membership_density[[web]] = findDensityModules(A_ecobase[[web]])
}

#PREDATOR/PREY-BASED MODULES
membership_predator = matrix(list(), length(A_ecobase),1)
membership_prey = matrix(list(), length(A_ecobase),1)
for (web in 1:length(A_ecobase)){
  if (length(A_ecobase[[web]]) > 1) {
    membership_predator[[web]] = findPredatorPreyModules(A_ecobase[[web]], "predator")
    membership_prey[[web]] = findPredatorPreyModules(A_ecobase[[web]], "prey")
    } else {
      membership_predator[[web]] = A_ecobase[[web]]
      membership_prey[[web]] = A_ecobase[[web]]
    }
  }

#WRITE
for (web in 1:length(A_ecobase)){
  path = 'results/membership_density_modularity/'
  name = paste0(path, "membership_density_", addFrontZeros(web), ".txt")
  write.table(membership_density[[web]], file = name, row.names = FALSE, col.names = FALSE, sep = ",")
  path = 'results/membership_prey_modularity/'
  name = paste0(path, "membership_prey_", addFrontZeros(web), ".txt")
  write.table(membership_prey[[web]], file = name, row.names = FALSE, col.names = FALSE, sep = ",")
  path = 'results/membership_predator_modularity/'
  name = paste0(path, "membership_predator_", addFrontZeros(web), ".txt")
  write.table(membership_predator[[web]], file = name, row.names = FALSE, col.names = FALSE, sep = ",")
}