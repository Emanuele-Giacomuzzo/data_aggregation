function[s]=svector(B,z)

[eigenvectors,eigenvalues]=eig(B{z}+B{z}');
[max_eigenvalue,linear_index]=max(eigenvalues,[],'all','linear');
[row,col] = ind2sub(size(eigenvalues),linear_index);
s=eigenvectors(:,row);
for i=1:length(s)
    if s(i)>0
        s(i)=1;
    elseif s(i)==0
        s(i)=0;
    elseif s(i)<0
        s(i)=-1;
    end
end

end