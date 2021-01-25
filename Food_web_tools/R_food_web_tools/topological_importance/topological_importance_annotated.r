data<-read.table("C:\\TI_R\\edge.txt", header=F)
numstep<-3
nodeID<-levels(factor(c(as.character(data[,1]),as.character(data[,2]))))
numnode<-length(nodeID)
mx<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode)
rownames(mx)<-nodeID
colnames(mx)<-nodeID
for (i in 1:length(data[,1])){
mx[as.character(data[i,1]),as.character(data[i,2])]<-1
}
TI<-mx
for (i in 1:numnode){
for (j in 1:numnode) TI[j,i]<-mx[j,i]/sum(mx[,i])}
SI<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode)
CI<-diag(numnode)
for (i in 1:numstep){
CI<-CI%*%TI
SI<-SI+CI}
TIindex<-numeric(numnode)
for (i in 1:numnode)TIindex[i]<-sum(SI[i,])/numstep
resu<-data.frame(nodeID,TIindex)
resu
