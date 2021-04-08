#This finds the density-based modules as defined in Guimerà, Roger, et al. "Origin of compartmentalization in food webs." Ecology 91.10 (2010): 2941-2951.

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
