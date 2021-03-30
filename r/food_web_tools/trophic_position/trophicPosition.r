#Predator and prey are inverted here. 
trophicPosition = function(A){
  
  intake_ratio = A
  nodes_number = sqrt(length(A))
  for (predator in 1:nodes_number){ 
    for (prey in 1:nodes_number) 
      if (intake_ratio[predator,prey] != 0) 
        intake_ratio[predator,prey] = A[predator,prey]/sum(A[predator,])
  }
  
  intake_tot = numeric(nodes_number)
  for (predator in 1:nodes_number){
    intake_tot[predator] = sum(intake_ratio[predator,])
  }
  autotrophs = which(intake_tot == 0)
  names(autotrophs) = nodeID[autotrophs]
  
  intake_ratio_heterotrophs = intake_ratio
  for (autotroph in 1:length(autotrophs)) {
    intake_ratio_heterotrophs = intake_ratio_heterotrophs[-which(rownames(intake_ratio_heterotrophs)==names(autotrophs[autotroph])), ]
    intake_ratio_heterotrophs = intake_ratio_heterotrophs[,-which(colnames(intake_ratio_heterotrophs)==names(autotrophs[autotroph]))]
  }
  
  diagonal_matrix = matrix(rep(0,(nodes_number-length(autotrophs))^2), nrow = (nodes_number-length(autotrophs)), ncol = (nodes_number-length(autotrophs)))
  for (node in 1:(nodes_number-length(autotrophs))) 
    diagonal_matrix[node,node] = 1
  
  solution = rep(1, (nodes_number-length(autotrophs))) 
  TP = solve((diagonal_matrix-intake_ratio_heterotrophs),solution)
  
  names(TP) = rownames(intake_ratio_heterotrophs)
  
  TP_autotrophs = autotrophs
  for (node in 1:length(TP_autotrophs)) 
    TP_autotrophs[node]=0
  TP = c(TP_autotrophs,TP)
  
  return(TP)
  
}