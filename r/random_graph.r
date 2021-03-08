library(igraph)
library(Matrix)
source('/Users/ema/github/data_aggregation/r/food_web_tools/trophic_position/trophicPosition.r')

G = erdos.renyi.game(10, 0.5, type = "gnp", directed = TRUE, loops = FALSE)
plot.igraph(G)
A = as_adjacency_matrix(G,sparse=T)
trophicPosition(A)