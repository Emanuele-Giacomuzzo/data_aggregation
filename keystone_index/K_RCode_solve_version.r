data<-read.table("C:\\Users\\JL\\Desktop\\WeiChungLiu\\K_Index\\web.txt", header=F)
nodeID<-levels(factor(c(as.character(data[,1]),as.character(data[,2]))))
numnode<-length(nodeID)
mx<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode)
rownames(mx)<-nodeID
colnames(mx)<-nodeID
for (i in 1:length(data[,1])){
mx[as.character(data[i,1]),as.character(data[i,2])]<-1
}

prey<-numeric(numnode)
for (i in 1:numnode) prey[i]<-sum(mx[,i])

predator<-numeric(numnode)
for (i in 1:numnode) predator[i]<-sum(mx[i,])

coef<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode)

for (i in 1:numnode) {coef[i,]<-prey*mx[i,]}
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]}
vw<-numeric(numnode)
for (i in 1:numnode) vw[i]<--1*sum(coef[i,])
for (i in 1:numnode) coef[i,i]<-coef[i,i]+(-1)
kbu<-solve(coef,vw)

for (i in 1:numnode) {coef[i,]<-predator*mx[,i]}
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]}
vw<-numeric(numnode)
for (i in 1:numnode) vw[i]<--1*sum(coef[i,])
for (i in 1:numnode) coef[i,i]<-coef[i,i]+(-1)
ktd<-solve(coef,vw)

for (i in 1:numnode) {coef[i,]<-prey*mx[i,]}
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]}
vw<-numeric(numnode)
for (i in 1:numnode) vw[i]<-sum(coef[i,])
kdir<-vw
for (i in 1:numnode) {coef[i,]<-kbu*coef[i,]}
kindir<-numeric(numnode)
for (i in 1:numnode) {kindir[i]<-sum(coef[i,])}

for (i in 1:numnode) {coef[,i]<-predator*mx[,i]}
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]}
vw<-numeric(numnode)
for (i in 1:numnode) vw[i]<-sum(coef[,i])
kdir<-kdir+vw
for (i in 1:numnode) {coef[,i]<-ktd*coef[,i]}
for (i in 1:numnode) {kindir[i]<-kindir[i]+sum(coef[,i])}

k<-kbu+ktd

resu<-data.frame(nodeID,k,kbu,ktd,kdir,kindir)
resu
