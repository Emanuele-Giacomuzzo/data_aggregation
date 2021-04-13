pdf(file = paste0("latex/figures/keystone_species.pdf"))
par(mfrow=c(2,3))
par(mar=c(1,1,3,1)) #bottom,left,top, right
for (clustering in 1:length(clustering_methods)){
  
  path = paste0('r/plotting/colors_original_',clustering_methods[clustering],'_web_', web, '.csv')
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
              vertex.size = 5,
              vertex.color = V(G)$color,
              vertex.shape = V(G)$shape,
              edge.arrow.size = .2,
              edge.color = '#90b6cd',
              rescale = F,
              asp = 0)
  title(titles[clustering],cex.main = 2)
}
dev.off()
