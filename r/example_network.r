rm(list = ls()); 
cat("\014"); 
setwd('/Users/ema/github/data_aggregation/r/plotting')
library(igraph)
source('../addFrontZeros.r')
web = 37
max_TP = 5.5
clustering_methods = c('Jaccard', 'REGE', 'density', 'prey', 'predator', 'groups')
titles = c('(a)', '(b)', '(c)', '(d)', '(e)', '(f)')
figure = 4

path = paste0('/Users/ema/github/data_aggregation/data/ecobase/adjacency_matrices/Adjacency_matrix_web_', addFrontZeros(web), '.txt')
A = read.csv(path, header = F)
A = as.matrix(A)

path = paste0('coordinates_original_web_',web,'.csv')
coordinates_original = read.csv(path, header = F)
coordinates_original = as.matrix(coordinates_original)

figure = figure + 1 
pdf(file = paste0("/Users/ema/github/data_aggregation/paper/figures/Figure_",figure,".pdf"))
par(mfrow=c(2,3))
par(mar=c(1,1,3,1)) #bottom,left,top, right
for (clustering in 1:length(clustering_methods)){
  
  path = paste0('colors_original_',clustering_methods[clustering],'_web_', web, '.csv')
  node_colors = read.csv(path, header = F)
  node_colors = as.matrix(node_colors)
  
  G = graph_from_adjacency_matrix(A, mode = "directed", weighted = TRUE, diag = TRUE)
  V(G)$color = node_colors
  #V(G)$shape = rep("square",times=55)
  plot.igraph(simplify(G),
              layout = coordinates_original,
              xlim = c(min(coordinates_original[,1]), max(coordinates_original[,1])),
              ylim = c(min(coordinates_original[,2]), max(coordinates_original[,2])),
              #axes = T,
              vertex.label = NA,
              vertex.size = 3,
              vertex.color = V(G)$color,
              vertex.shape = V(G)$shape,
              edge.arrow.size = .2,
              edge.color = '#90b6cd',
              rescale = F,
              asp = 0)
  title(titles[clustering],cex.main = 2)
}
dev.off()
caption = "Effect of aggregation on most the most important nodes in a food web. Red: central before and central after. Orange: central before and not central after. Purple: not central before and central after. Blue: not central before and not central after. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. The food web of this figure is the one of the West Florida Shelf (Okey, 2004a)) and the largest network we used (55 nodes)."
write.table(caption,paste0("/Users/ema/github/data_aggregation/paper/figures/Caption_figure_", figure,".txt"),col.names = F, row.names = F)


figure = figure + 1 
pdf(file = paste0("/Users/ema/github/data_aggregation/paper/figures/Figure_",figure,".pdf"))
par(mfrow=c(2,3))
par(mar=c(1,1,3,1)) #bottom,left,top, right
for (clustering in 1:length(clustering_methods)){
  
  path = paste0('A_',clustering_methods[clustering],'_web_', web, '.csv')
  A_clustered = read.csv(path, header = F)
  A_clustered = as.matrix(A_clustered)
  G = graph_from_adjacency_matrix(A_clustered, mode = "directed", weighted = TRUE, diag = TRUE)
  
  path = paste0('cluster_sizes_',clustering_methods[clustering],'_web_', web, '.csv')
  cluster_sizes = read.csv(path, header = F)
  cluster_sizes = as.matrix(cluster_sizes)
  V(G)$sizes = cluster_sizes
  
  path = paste0('coordinates_',clustering_methods[clustering],'_web_', web, '.csv')
  coordinates_clustered = read.csv(path, header = F)
  coordinates_clustered = as.matrix(coordinates_clustered)
  
  if (clustering == 3) {
    vertex_sizes = sqrt(cluster_sizes)*0.4
    arrow_size = 2
    xlim = c(min(coordinates_clustered[,1])-0.01, max(coordinates_clustered[,1])+0.01)
    ylim = c(min(coordinates_clustered[,2])-3,max(coordinates_clustered[,2])+3)
  } else if (clustering == 6){
    vertex_sizes = sqrt(cluster_sizes)#*0.5
    arrow_size = 1
    xlim = c(min(coordinates_clustered[,1]), max(coordinates_clustered[,1]))
    ylim = c(min(coordinates_clustered[,2])-2,max(coordinates_clustered[,2])+2)
  }  else {
    vertex_sizes = sqrt(cluster_sizes)*5
    arrow_size = .2
    xlim = c(min(coordinates_clustered[,1]), max(coordinates_clustered[,1]))
    ylim = c(min(coordinates_clustered[,2]), max(coordinates_clustered[,2]))
  }
  
  plot.igraph(simplify(G),
              layout = coordinates_clustered,
              xlim = xlim,
              ylim = ylim,
              #axes = T,
              vertex.label = NA,
              vertex.size = vertex_sizes,
              vertex.color = "#44ABE7",
              edge.arrow.size = arrow_size,
              edge.color = "#90b6cd",
              rescale = F,
              asp = 0
  )
  title(titles[clustering],cex.main = 2)
  
}
dev.off()

caption = "Aggregation of the food web of Figure 5 according to different clustering algortihms. The size of the nodes is prortional to the number of nodes that have been aggregated into them. The self-loops are not included in the figure for clarity. (a) = jaccard, (b) = rege, (c) = density-based modules, (d) = prey-based modules, (e) = predator-based modules, (f) = groups found by the group model. As you can see in (d), aggregation might cause to produce a node that is not connected to the rest of the network."
write.table(caption,paste0("/Users/ema/github/data_aggregation/paper/figures/Caption_figure_", figure,".txt"),col.names = F, row.names = F) 