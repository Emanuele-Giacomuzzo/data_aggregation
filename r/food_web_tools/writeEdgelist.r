writeEdgelist = function (A,name) {

  edgelist = matrix(,nrow = 0, ncol = 3)
  for (prey in 1:ncol(A)){
    for (predator in 1:ncol(A)) {
      if (A[prey,predator] != 0){
        edgelist = rbind(edgelist, c(node_names[[prey]], node_names[[predator]], A[prey,predator]))
      }
    }
  }
  
  write.table(edgelist,file = paste0('edgelist_',name,'.csv'), row.names = FALSE, col.names = FALSE,sep = "\t", quote = F)
  
}