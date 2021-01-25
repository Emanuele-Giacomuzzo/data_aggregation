library(igraph)
library(NetIndices)
setwd('/Users/ema/Github/Data_aggregation/R_files')

#Import data
edge_list <- read.delim('../data/edge_list_for_R.txt', header = FALSE)
edge_list_jaccard <- read.delim('../variables/edge_list_jaccard.txt', header = FALSE)
edge_list_rege <- read.delim('../variables/edge_list_rege.txt', header = FALSE)
edge_list_prey_modularity <- read.delim('../variables/edge_list_prey_modularity.txt', header = FALSE)
edge_list_density_modularity <- read.delim('../variables/edge_list_density_modularity.txt', header = FALSE)
edge_list_groups <- read.delim('../variables/edge_list_groups.txt', header = FALSE)
membership <- read.csv('../variables/membership.txt',header = FALSE)
TP <- data.matrix(read.delim('TP.txt', header = FALSE))

#Create food web
edges <- data.matrix(edge_list[,c("V1","V2")]) 
edges <- edges[,c("V2","V1")]#You need to invert i and j
weights<-edge_list[,"V3"]
G <- graph_from_edgelist(edges)
G$weight <- weights
#A<-get.adjacency(G,sparse=F) #i and j are inverted
#indices<-GenInd(A)

# Plot food web - original
V(G)$TP <- TP
layout.matrix<-matrix( nrow=length(V(G)),ncol=2)
layout.matrix[,1]<-runif(length(V(G)))
layout.matrix[,2] <- TP
V(G)$color <- "666"
plot.igraph(G,
            main= "Original food web ",
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            axes=TRUE,
            xlim = c(0,1),
            ylim=c(0,3),
            ylab="Trophic position (TP)",
            rescale=F,
            asp=0)

par(mfrow=c(1,2)) 
#Colour clusters
V(G)$jaccard <- membership[,1] #OR G <- set_vertex_attr(G,"module",value=membership)
V(G)$color <- V(G)$jaccard
plot.igraph(G,
            main = "(a)", #Clustering through the jaccard index
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            #axes=T,
            #ylab="Trophic position (TP)"
)

V(G)$rege <- membership[,2] 
V(G)$color <- V(G)$rege
plot.igraph(G,
            main = "(c)", #Clustering through the rege index
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            #axes=T,
            #ylab="Trophic position (TP)"
)

V(G)$preymodularity <- membership[,3] 
V(G)$color <- V(G)$preymodularity
plot.igraph(G,
            main = "(e)", #Clustering through prey modularity maximisation
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            #axes=T,
            #ylab="Trophic position (TP)"
)

V(G)$densitymodularity <- membership[,4] 
V(G)$color <- V(G)$densitymodularity
plot.igraph(G,
            #main = "(g)", #Clustering through density modularity maximisation
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            #axes=T,
            #ylab="Trophic position (TP)"
)

V(G)$groups <- membership[,5]
V(G)$color <- V(G)$groups
plot.igraph(G,
            #main = "(i)", #Clustering through the signed group model
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            #axes=T,
            #ylab="Trophic position (TP)"
)