function [nDC,nwDC,nCC,nBC,s,cs,ns,k,kbu,ktd,kdir,kindir,TI,TI_ratio,STO,STO_ratio,TP] = initialiseCentrality(a,n)

nDC=zeros(n,a+1); 
nwDC=zeros(n,a+1); 
nCC=zeros(n,a+1); 
nBC=zeros(n,a+1); 
s=zeros(n,a+1); 
cs=zeros(n,a+1); 
ns=zeros(n,a+1); 
k=zeros(n,a+1); 
kbu=zeros(n,a+1); 
ktd=zeros(n,a+1); 
kdir=zeros(n,a+1); 
kindir=zeros(n,a+1); 
TI=zeros(n,a+1); 
TI_ratio=zeros(n,a+1); 
STO=zeros(n,a+1); 
STO_ratio=zeros(n,a+1);
TP=zeros(n,a+1); 

end