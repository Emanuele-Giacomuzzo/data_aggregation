#This function works specifically for the trophic position code of Wei-Chung Liu. 
#You need all the species to be connected inside the network to be able to run this program. 
#Watch out also for this: the matrix that produces has rows as predators and columns as preys.

readEdgelist = function (file_name) {
  
  data = read.table(file_name, header = T, sep = ",")
  
  nodeID = levels(factor(c(as.character(data[,1]), as.character(data[,2]))))
  
  nr_of_nodes = length(nodeID)
  A = matrix(rep(0, nr_of_nodes^2), nrow = nr_of_nodes, ncol = nr_of_nodes)
  rownames(A) = nodeID
  colnames(A) = nodeID
  
  for (node in 1:length(data[,1])){ 
    A[as.character(data[node,2]), as.character(data[node,1])] = data[node,3]
  }
  
  for (node in 1:nr_of_nodes){
    A[node,node] = 0
  }
  
  return(A)

}