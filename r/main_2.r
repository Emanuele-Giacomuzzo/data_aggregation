setwd('/Users/ema/github/data_aggregation')
rm(list = ls()); 
cat("\014"); 
library(igraph)
source('r/addFrontZeros.r')

web = 37
max_TP = 5.5
clustering_methods = c('Jaccard', 'REGE', 'density', 'prey', 'predator', 'groups')
titles = c('(a)', '(b)', '(c)', '(d)', '(e)', '(f)')

path = paste0('data/adjacency_matrices/Adjacency_matrix_web_', addFrontZeros(web), '.txt')
A = read.csv(path, header = F)
A = as.matrix(A)

path = paste0('r/plotting/coordinates_original_web_',web,'.csv')
coordinates_original = read.csv(path, header = F)
coordinates_original = as.matrix(coordinates_original)

#Figure of the keystone species
source('r/figure_keystone_species.r')
caption = "Effect of aggregation on most the most important nodes in a food web. Red: central before and central after. Orange: central before and not central after. Purple: not central before and central after. Blue: not central before and not central after. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. The food web of this figure is the one of the West Florida Shelf (Okey, 2004a)) and the largest network we used (55 nodes)."
write.table(caption, "latex/captions//caption_figure_keystone_species.txt", col.names = F, row.names = F)

#Figure of the aggregated webs
source('r/figure_aggregated_webs.r')
caption = "Aggregation of the food web of Figure 5 according to different clustering algortihms. The size of the nodes is prortional to the number of nodes that have been aggregated into them. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. As you can see in (d), aggregation might cause to produce a node that is not connected to the rest of the network."
write.table(caption, "latex/captions/caption_figure_aggregated_webs.txt", col.names = F, row.names = F)