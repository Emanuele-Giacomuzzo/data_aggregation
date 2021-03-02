#Coming from this link: in igraph for Python: https://igraph.org/c/doc/igraph-Community.html
import igraph
from igraph import *
import cairo

g = Graph.Read_Adjacency('/Users/ema/github/data_aggregation/data/adjacency_matrix_binary.txt')
print(g)

int igraph_modularity(g,
                      const igraph_vector_t *membership,
                      const igraph_vector_t *weights,
                      const igraph_real_t resolution,
                      const igraph_bool_t directed,
                      igraph_real_t *modularity);
