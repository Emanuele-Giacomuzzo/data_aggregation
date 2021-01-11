function [clusterID_nDC,A_nDC,clusterID_nwDC,A_nwDC,clusterID_nCC,A_nCC,clusterID_nBC,A_nBC,clusterID_s,A_s,clusterID_cs,A_cs,clusterID_ns,A_ns,clusterID_k,A_k,clusterID_kbu,A_kbu,clusterID_ktd,A_ktd,clusterID_kdir,A_kdir, clusterID_kindir, A_kindir,clusterID_TI,A_TI,clusterID_TIratio,A_TIratio,clusterID_TO,A_TO,clusterID_TOratio, A_TOratio,nDC,nwDC,nCC,nBC,s,cs,ns,k,kbu,ktd,kdir,kindir,TI,TIratio,TO,TOratio] = initialise(n);

clusterID_nDC=zeros(n,5); clusterID_nwDC=zeros(n,5); clusterID_nCC=zeros(n,5);
clusterID_nBC=zeros(n,5); clusterID_s=zeros(n,5); clusterID_cs=zeros(n,5); 
clusterID_ns=zeros(n,5); clusterID_k=zeros(n,5); clusterID_kbu=zeros(n,5); 
clusterID_ktd=zeros(n,5); clusterID_kdir=zeros(n,5); clusterID_kindir=zeros(n,5); 
clusterID_TI=zeros(n,5); clusterID_TIratio=zeros(n,5); clusterID_TO=zeros(n,5); 
clusterID_TOratio=zeros(n,5); 

for i=1:5
A_nDC{i}=zeros(n,5); A_nwDC{i}=zeros(n,5); A_nCC{i}=zeros(n,5);
A_nBC{i}=zeros(n,5); A_s{i}=zeros(n,5); A_cs{i}=zeros(n,5); A_ns{i}=zeros(n,5); A_k{i}=zeros(n,5);
A_kbu{i}=zeros(n,5); A_ktd{i}=zeros(n,5); A_kdir{i}=zeros(n,5); A_kindir{i}=zeros(n,5);
A_TI{i}=zeros(n,5); A_TIratio{i}=zeros(n,5); A_TO{i}=zeros(n,5); A_TOratio{i}=zeros(n,5);
end

nDC=zeros(n,6); nwDC=zeros(n,6); nCC=zeros(n,6); nBC=zeros(n,6); s=zeros(n,6); 
cs=zeros(n,6); ns=zeros(n,6); k=zeros(n,6); kbu=zeros(n,6); ktd=zeros(n,6); 
kdir=zeros(n,6); kindir=zeros(n,6); TI=zeros(n,6); TIratio=zeros(n,6); 
TO=zeros(n,6); TOratio=zeros(n,6); 

end