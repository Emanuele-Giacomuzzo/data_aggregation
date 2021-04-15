#This needs to be run after the analysis in MATLAB. It produces the figures and the table.
setwd('/Users/ema/github/data_aggregation')
rm(list = ls()); 
cat("\014"); 
library(igraph)
library(data.table)
library(dplyr)
library(formattable)
library(tidyr)
library(xtable)
library(stringi)
source('r/addFrontZeros.r')
source('r/writeRankingTables.r')

web = 37
A = as.matrix(read.csv(paste0('data/adjacency_matrices/Adjacency_matrix_web_', addFrontZeros(web), '.txt'), header = F))
coordinates_original = as.matrix(read.csv(paste0('r/plotting/coordinates_original_web_',web,'.csv'), header = F))

#Figure of the keystone species
source('r/save_figure_keystones.r')
caption = "Effect of aggregation on most the most important nodes in a food web. Red: central before and central after. Orange: central before and not central after. Purple: not central before and central after. Blue: not central before and not central after. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. The food web of this figure is the one of the West Florida Shelf (Okey, 2004a)) and the largest network we used (55 nodes)."
write.table(caption, "latex/captions//caption_figure_keystone_species.txt", col.names = F, row.names = F)

#Figure of the aggregated webs
source('r/save_figure_aggregated_webs.r')
caption = "Aggregation of the food web of Figure 5 according to different clustering algortihms. The size of the nodes is prortional to the number of nodes that have been aggregated into them. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. As you can see in (d), aggregation might cause to produce a node that is not connected to the rest of the network."
write.table(caption, "latex/captions/caption_figure_aggregated_webs.txt", col.names = F, row.names = F)

#Ranking table
centralities = paste(unlist(read.csv("results/tables/centralities.txt", header = F)))
for (centrality in 1:length(centralities)){
  centralities[centrality] = paste0('\\(\\displaystyle ', centralities[centrality], " \\) &")
}

table = "rank_table"
caption = "\\caption{Table of the best Kendall’s correlation coefficients. They are ranked from the clustering that produced the best correlation, to the clustering that produced the worst correlation.  {\\color[HTML]{00D768} Green = hierarchical clustering with Jaccard index}, {\\color[HTML]{EF2A00} red = hierarchical clustering with REGE index}, {\\color[HTML]{9B9B9B} grey = density-based modules}, {\\color{orange} yellow = prey-based modules}, {\\color[HTML]{0051D7} blue = predator-based modules}, {\\color[HTML]{6200D7} purple = groups produced by the group model}. C1 = Best clustering, C2 = second best clustering, C3 = third best clustering, C4 = fourth best clustering, C5 = fifth best clustering, C6 = sixth best clustering.}"
writeRankingTables(table,caption)

table = "rank_table_ci"
caption = "\\caption{Confidence intervals of the mean Kendalls in Table 1.}"
writeRankingTables(table,caption)

table = "rank_table_aggregations"
caption = "\\caption{Combination of linkage method and interaction strength method that gave us the highest Kendall's correlation coefficient. Most of the cells do not containi the interaction strength method because they are computed upon a binary network.}"
writeRankingTables(table,caption)