clustering_methods = c('Jaccard', 'REGE', 'density', 'prey', 'predator', 'groups')

pdf(file = "latex/figures/aggregated_web.pdf")
par(mfrow=c(2,3))
par(mar=c(1,1,3,1)) #bottom,left,top, right
for (clustering in 1:length(clustering_methods)){
  
  path = paste0('r/plotting/A_',clustering_methods[clustering],'_web_', web, '.csv')
  A_clustered = read.csv(path, header = F)
  A_clustered = as.matrix(A_clustered)
  G = graph_from_adjacency_matrix(A_clustered, mode = "directed", weighted = TRUE, diag = TRUE)
  
  path = paste0('r/plotting/cluster_sizes_',clustering_methods[clustering],'_web_', web, '.csv')
  cluster_sizes = read.csv(path, header = F)
  cluster_sizes = as.matrix(cluster_sizes)
  V(G)$sizes = cluster_sizes
  
  path = paste0('r/plotting/coordinates_',clustering_methods[clustering],'_web_', web, '.csv')
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