#You need to run main first. 

edge_list_jaccard <- read.delim('../variables/edge_list_jaccard.txt', header = FALSE)
edge_list_rege <- read.delim('../variables/edge_list_rege.txt', header = FALSE)
edge_list_prey_modularity <- read.delim('../variables/edge_list_prey_modularity.txt', header = FALSE)
edge_list_density_modularity <- read.delim('../variables/edge_list_density_modularity.txt', header = FALSE)
edge_list_groups <- read.delim('../variables/edge_list_groups.txt', header = FALSE)

#TP_jaccard <- as.matrix(read.csv('../variables/TP_jaccard_clusters.txt', header = FALSE))
#TP_rege <- as.matrix(read.csv(''))

#JACCARD FOOD WEB
G_jaccard <- graph_from_edgelist(as.matrix(edge_list_jaccard[,c("V2","V1")])) #You need to invert i and j
V(G_jaccard)$TP <- TP_jaccard
layout.matrix<-matrix( nrow=length(V(G_jaccard)),ncol=2)
layout.matrix[,1]<-runif(length(V(G_jaccard)))
layout.matrix[,2] <- TP_jaccard
V(G_jaccard)$color <- "666" #V(G_jaccard)
plot.igraph(G_jaccard,
            main= "Jaccard food web",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=TRUE,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

#REGE FOOD WEB
edges_rege <- edge_list_rege[,c("V2","V1")] #You need to invert i and j
G_rege <- graph_from_edgelist(edges_rege)
weights_rege<-edge_list_rege[,"V3"]
G_rege$weight <- weights_rege
#V(G_rege)$TP <- TP
layout.matrix<-matrix( nrow=length(V(G_rege)),ncol=2)
layout.matrix[,1]<-runif(length(V(G_rege)))
#layout.matrix[,2] <- TP
#V(G_rege)$color <- 
plot.igraph(G_rege,
            main= "REGE food web",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=TRUE,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

#PREY MODULARITY FOOD WEB
edges_preymodularity <- edge_list_preymodularity[,c("V2","V1")] #You need to invert i and j
G_preymodularity <- graph_from_edgelist(edges_preymodularity)
weights_preymodularity<-edge_list_preymodularity[,"V3"]
G_preymodularity$weight <- weights_preymodularity
#V(G_preymodularity)$TP <- TP
layout.matrix<-matrix( nrow=length(V(G_preymodularity)),ncol=2)
layout.matrix[,1]<-runif(length(V(G_preymodularity)))
#layout.matrix[,2] <- TP
#V(G_preymodularity)$color <- 
plot.igraph(G_preymodularity,
            main= "Prey modules food web",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=TRUE,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

#DENSITY MODULARITY FOOD WEB
edges_densitymodularity <- edge_list_densitymodularity[,c("V2","V1")] #You need to invert i and j
G_densitymodularity <- graph_from_edgelist(edges_densitymodularity)
weights_densitymodularity<-edge_list_densitymodularity[,"V3"]
G_densitymodularity$weight <- weights_densitymodularity
#V(G_densitymodularity)$TP <- TP_densitymodularity
layout.matrix<-matrix( nrow=length(V(G_densitymodularity)),ncol=2)
layout.matrix[,1]<-runif(length(V(G_densitymodularity)))
#layout.matrix[,2] <- TP
#V(G_densitymodularity)$color <- 
plot.igraph(G_densitymodularity,
            main= "Density modules food web",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=TRUE,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

#GROUP MODEL FOOD WEB - create
edges_groups <- edge_list_groups[,c("V2","V1")] #You need to invert i and j
G_groups <- graph_from_edgelist(edges_groups)
weights_groups<-edge_list_groups[,"V3"]
G_groups$weight <- weights_groups
#V(G_groups)$TP <- TP
layout.matrix<-matrix( nrow=length(V(G_groups)),ncol=2)
layout.matrix[,1]<-runif(length(V(G_groups)))
#layout.matrix[,2] <- TP
#V(G_groups)$color <- 
plot.igraph(G_groups,
            main= "Group modules food web", 
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=TRUE,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)