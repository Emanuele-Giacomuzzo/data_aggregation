#This finds the prey-based modules or predator-based modules as defined in
#Guimerà, Roger, et al. "Origin of compartmentalization in food webs." Ecology 91.10 (2010): 2941-2951.

findPredatorPreyModules = function(A,role){

  if (role == "predator") {
    A = t(A)
  }

  #Bug fix: netcarto doesn't run if the rows and columns don't have a name
  rownames(A) = 1:nrow(A)
  colnames(A) = 1:nrow(A)

  membership = netcarto(A, bipartite = TRUE)

  membership = data.frame(as.numeric(as.character(membership[[1]]$name)),as.numeric(as.character(membership[[1]]$module)))
  colnames(membership) = c("node","module")
  membership = membership %>%
    arrange(node)
  membership[,2] = membership[,2]+1

  membership_complete = data.frame(1:nrow(A),integer(nrow(A)))
  colnames(membership_complete) = c("node","module")
  max = max(membership$module)
  for (node in 1:nrow(A)){
    row = which(membership$node == node)
    if (length(row) != 0){
      membership_complete$module[node] = membership$module[row]
    } else {
      membership_complete$module[node] = max+1
      max = max+1
    }
  }

  membership_complete = membership_complete$module

  return(membership_complete)

}
