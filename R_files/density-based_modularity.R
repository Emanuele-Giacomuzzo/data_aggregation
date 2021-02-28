if (!requireNamespace("devtools"))
  install.packages("devtools")
devtools::install_github("TomKellyGenetics/leiden")

install.packages("leiden")
library("leiden")

#Import A

library("igraph")
rownames(adjacency_matrix) <- 1:60
colnames(adjacency_matrix) <- 1:60
graph_object <- graph_from_adjacency_matrix(adjacency_matrix, mode = "directed")
graph_object

plot(graph_object, vertex.color = "grey75")

library("igraph")
adjacency_matrix <- igraph::as_adjacency_matrix(graph_object)

partition <- leiden(adjacency_matrix)

table(partition)

library("RColorBrewer")
node.cols <- brewer.pal(max(c(3, partition)),"Pastel1")[partition]
plot(graph_object, vertex.color = node.cols)
