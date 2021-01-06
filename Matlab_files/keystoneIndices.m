function[]=keystoneIndices()

clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/keystone_index/Matlab_files';
load web.mat; % i (prey) -> j (predator)
n=length(web);
preys=sum(web); preys=preys.';
predators=sum(web,2);

prey_coefficients=preyCoefficients(web,preys,n);
vw=sum(prey_coefficients,2)*-1;
diagonal=diag(ones(n,1)*-1); prey_coefficients_updated=prey_coefficients+diagonal;
kbu=linsolve(prey_coefficients_updated,vw);

predator_coefficients=predatorCoefficients(web,predators,n);
vw=sum(predator_coefficients,2)*-1;
predator_coefficients_updated=predator_coefficients+diagonal;
ktd=linsolve(predator_coefficients_updated,vw);

for i=1:n
    k(i)=kbu(i)+ktd(i);
end

kdir=sum(prey_coefficients,2);

kindir=kIndirect(prey_coefficients,kbu,n);

predator_coefficients_col = predatorCoefficientsCol(web,predators,n);
vw=sum(predator_coefficients_col);
for i=1:n
    kdir(i)=kdir(i)+vw(i);
end

for i=1:n
    for j=1:n
        predator_coefficients_col(i,j)=ktd(i)*predator_coefficients_col(i,j);
    end
end
predator_coefficients_col_sum=sum(predator_coefficients_col);
for i=1:n
    kindir(i)=kindir(i)+predator_coefficients_col_sum(i);
end

end