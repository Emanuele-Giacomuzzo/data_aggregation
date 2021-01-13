getwd()
data<-read.table("web.txt", header=F)
nodeID<-levels(factor(c(as.character(data[,1]),as.character(data[,2])))) #Factor=categorical variable c=combine as.charachter=whatever2char. This line takes all the values of the first two coloumns and stores them as levels of factor nodeID. 
numnode<-length(nodeID)
mx<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode)
rownames(mx)<-nodeID
colnames(mx)<-nodeID
for (i in 1:length(data[,1])){ 
  mx[as.character(data[i,2]),as.character(data[i,1])]<-data[i,3]
  }

Tmx<-mx
for (i in 1:numnode){ 
  for (j in 1:numnode) 
    if (Tmx[i,j]!=0) 
      Tmx[i,j]<-mx[i,j]/sum(mx[i,])
}

diet<-numeric(numnode)
for (i in 1:numnode){
  diet[i]<-sum(Tmx[i,])
}
sou<-which(diet==0) #which=position of the certain values. 
names(sou)<-nodeID[sou] #names=names the coloumns/rows

Qmx<-Tmx
for (i in 1:length(sou)) {
  Qmx<-Qmx[-which(rownames(Qmx)==names(sou[i])),]
  Qmx<-Qmx[,-which(colnames(Qmx)==names(sou[i]))]
}

Imx<-matrix(rep(0,(numnode-length(sou))^2),nrow=(numnode-length(sou)),ncol=(numnode-length(sou)))
for (i in 1:(numnode-length(sou))) 
  Imx[i,i]<-1

vw<-rep(1, (numnode-length(sou)))
tp<-solve((Imx-Qmx),vw)

names(tp)<-rownames(Qmx)
soutp<-sou
for (i in 1:length(soutp)) 
  soutp[i]<-0
tp<-c(soutp,tp)
tp