edgelist = matrix(,nrow = 0, ncol = 2)
for (i in 1:ncol(A)){
  for (j in 1:ncol(A)) {
    if (A[i,j] != 0){
      x = c(i,j)
      edgelist = rbind(edgelist, x)
    }
  }
}
