function [A_nDC,A_nwDC,A_nCC,A_nBC,A_s,A_cs,A_ns,A_k,A_kbu,A_ktd,A_kdir,A_kindir,A_TI,A_TI_ratio,A_STO,A_STO_ratio,A_TP] = initialiseA(n,a)

for i=1:a
    A_nDC{i}=zeros(n,a); 
    A_nwDC{i}=zeros(n,a); 
    A_nCC{i}=zeros(n,a); 
    A_nBC{i}=zeros(n,a);
    A_s{i}=zeros(n,a); 
    A_cs{i}=zeros(n,a); 
    A_ns{i}=zeros(n,a); 
    A_k{i}=zeros(n,a); 
    A_kbu{i}=zeros(n,a); 
    A_ktd{i}=zeros(n,a); 
    A_kdir{i}=zeros(n,a); 
    A_kindir{i}=zeros(n,a);
    A_TI{i}=zeros(n,a); 
    A_TI_ratio{i}=zeros(n,a); 
    A_STO{i}=zeros(n,a); 
    A_STO_ratio{i}=zeros(n,a);
    A_TP{i}=zeros(n,a);
end


end