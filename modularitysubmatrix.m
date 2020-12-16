function[B]=modularitysubmatrix(modules,B_matrix,z)

row_coloumn_summed=zeros(length(modules{1}),1);

for i=1:length(modules{1}) 
    for j=1:length(modules{1}) 
        if (modules{z}(i)==i) && (modules{z}(j)==j)
            for k=1:length(modules{1}) 
                row_coloumn_summed(j)=row_coloumn_summed(j)+B_matrix(j,k)+B_matrix(k,j);
            end
            I=sym(i); J=sym(j); kronecker=double(kroneckerDelta(I,J));
            B(j,i)=B_matrix(j,i)-(1/2)*kronecker*row_coloumn_summed(j);
        else
            B(j,i)=0;
        end
        
   end
end


end

%