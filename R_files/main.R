library(igraph)

#Create graph
edge_list<-read.delim('../data/edge_list_for_R.txt', header = FALSE)
edges <- edge_list[,c("V1","V2")]
edges = data.matrix(edges)
edges <- edges[,c("V2","V1")]#You need to invert i and j
G <- graph_from_edgelist(edges)
weights<-edge_list[,"V3"]
G$weight <- weights
plot.igraph(G)

#Signed group model colours
moduleID <- read.delim('../data/group_model_results.txt', header = FALSE)
V(G)$module <- #how can I assign the attributes from a vector?
vertex_attr(G, modules, index = V(G)) <- moduleID

V(G)$module <- moduleID
colrs <- rainbow(max(moduleID))
moduleID <- unlist(moduleID)
V(G)$color <- colrs[V(G)$module]

