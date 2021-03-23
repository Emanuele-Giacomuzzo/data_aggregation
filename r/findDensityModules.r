findDensityModules = function (A){
    if (length(A) > 1) {
      G = graph_from_adjacency_matrix(A, mode = "directed", weighted = "true", diag = TRUE)
      membership_density = leiden(G)
      }
    else {
      membership_density = A
    }
    return(membership_density)
}