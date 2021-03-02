rm(list = ls()); cat("\014"); setwd('/Users/ema/Github/Data_aggregation/R_files')
library(leiden)
library(ggplot2)
library(tibble)
library(plyr)
library(igraph)
library(NetIndices)
library(dplyr)
library(RColorBrewer)

#Create graph
edge_list <- read.delim('../data/Napoli_edgelist_for_R.txt', header = FALSE)
links <- edge_list %>% select(V1,V2)
weights <- edge_list %>% select(V3)
G <- graph_from_edgelist(as.matrix(links)) #You need to invert i and j
E(G)$weight <- as.matrix(weights)

#Add properties
TP <- as.matrix(read.csv('../data/variables/Napoli_TP.txt', header = FALSE))
V(G)$TP <- TP[,1]
#membership <- read.csv('../variables/membership.txt',header = FALSE)

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

#Density-based modularity
A <- get.adjacency(G,sparse=F) #Adjacency (i and j are inverted)
A <- t(A)
rownames(A) <- 1:nrow(A)
colnames(A) <- 1:nrow(A)
#partition <- leiden(A)
node.cols <- brewer.pal(max(c(3, partition)),"Pastel1")[partition]
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