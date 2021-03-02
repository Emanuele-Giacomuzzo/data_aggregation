xaxis = runif(length(V(G)), -max(TP[,1]), max(TP[,1]))
nodelist = cbind(0:61, 0:61,TP[,1],xaxis)
names = c("Id","Names","trophic_position","xaxis")
nodelist %>% 
  write.table(.,file = "/Users/ema/github/data_aggregation/gephi_files/Napoli_Gephi_nodelist.csv",row.names=FALSE, col.names=names, sep="\t")