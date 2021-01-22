library(igraph)
library(NetIndices)

#Create graph
edge_list<-read.delim('../data/edge_list_for_R.txt', header = FALSE)
edges <- data.matrix(edge_list[,c("V1","V2")])
edges <- edges[,c("V2","V1")]#You need to invert i and j
weights<-edge_list[,"V3"]
G <- graph_from_edgelist(edges)
G$weight <- weights
A<-get.adjacency(G,sparse=F) #i and j are inverted

#Get basic informations about the web
indices<-GenInd(A)

# First we need to create a two-column matrix identifying the x and y values for each node.
TP <- data.matrix(read.delim('TP.txt', header = FALSE))
V(G)$TP <- TP
layout.matrix<-matrix( nrow=length(V(G)),ncol=2)
layout.matrix[,1]<-runif(length(V(G)))
layout.matrix[,2] <- TP
V(G)$color <- "gray"
plot.igraph(G,
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

#Signed group model
moduleID <- read.delim('../data/group_model_results.txt', header = FALSE)
moduleID <- as.matrix(moduleID)
V(G)$module <- moduleID #OR G <- set_vertex_attr(G,"module",value=moduleID)
V(G)$color <- V(G)$module
plot.igraph(G,
            main = "Clustering through the signed group model",
            vertex.label.cex=1,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            rescale=F,
            asp=0,
            axes=T,
            ylab="Trophic position (TP)"
            )