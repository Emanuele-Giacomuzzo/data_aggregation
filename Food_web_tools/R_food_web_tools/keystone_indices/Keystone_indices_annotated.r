#Create the adjacency matrix
data<-read.table("web.txt", header=F)
nodeID<-levels(factor(c(as.character(data[,1]),as.character(data[,2])))) #Factor=categorical variable, c=combines multiple things
numnode<-length(nodeID)
mx<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode) #Rep=repeats a certain value a certain number of times
rownames(mx)<-nodeID
colnames(mx)<-nodeID
for (i in 1:length(data[,1])){
mx[as.character(data[i,1]),as.character(data[i,2])]<-1 #as.charachter converts from numeric object to categorical object
}

#Number of preys and predators of species
prey<-numeric(numnode)
for (i in 1:numnode) prey[i]<-sum(mx[,i]) #Prey is the number of preys of a certain species
predator<-numeric(numnode)
for (i in 1:numnode) predator[i]<-sum(mx[i,]) #Predator is the number of predators of a certain species 

#Initialise the coefficients of the linear equations
coef<-matrix(rep(0,numnode^2),nrow=numnode,ncol=numnode) 

#Bottom-up
for (i in 1:numnode) {coef[i,]<-prey*mx[i,]} #Now every interaction in the A instead of being 1, it's the number of preys of the predator
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]} #Now compute the inverse of the coefficients (diet fraction of the predator)
vw<-numeric(numnode) #Solutions (y) to the linear equations
for (i in 1:numnode) vw[i]<--1*sum(coef[i,]) #Negation of the sum of the row
for (i in 1:numnode) coef[i,i]<-coef[i,i]+(-1) #Assign to every value of the diagonal the value -1 
kbu<-solve(coef,vw) #solve system of linear equations

#Top-down
for (i in 1:numnode) {coef[i,]<-predator*mx[,i]} 
for (i in 1:numnode) for (j in 1:numnode) {if (coef[i,j]!=0) coef[i,j]<-1/coef[i,j]}
vw<-numeric(numnode)
for (i in 1:numnode) vw[i]<--1*sum(coef[i,])
for (i in 1:numnode) coef[i,i]<-coef[i,i]+(-1)
ktd<-solve(coef,vw)

#Direct & indirect effects
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