function [modules] = densitybasedmodularity(adj_dir_binary)

%Initialise parameters
adj_dir_binary=adj_dir_binary;
indegree=zeros(length(adj_dir_binary),1);
outdegree=zeros(length(adj_dir_binary),1);
Q_v=zeros(length(adj_dir_binary),1);
finetune_increase=1;
average_sum=0;
row_coloumn_summed=zeros(length(adj_dir_binary),1);
for i=1:64 modules{i}=zeros(length(adj_dir_binary),1); end
for i=1:length(adj_dir_binary) modules{1}(i)=i; end
for i=1:64 B{i}=zeros(length(adj_dir_binary),length(adj_dir_binary)); end
delta_Q=0;
m=0;
for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if adj_dir_binary(i,j)>0
            m=m+1;
        end
    end
end
for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if adj_dir_binary(i,j)>0 
            indegree(j)=indegree(j)+1;
        end
    end
end
for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary) 
        if adj_dir_binary(j,i)>0 
            outdegree(i)=outdegree(i)+1;
        end
    end
end

%Modularity matrix
for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        B{1}(i,j)=adj_dir_binary(i,j)-((indegree(i)*outdegree(j))/m);
    end
end
[eigenvectors,eigenvalues]=eig(B{1}+B{1}');
[max_eigenvalue,linear_index]=max(eigenvalues,[],'all','linear');
[row,col] = ind2sub(size(eigenvalues),linear_index);
s=eigenvectors(:,row);
for i=1:length(s)
    if s(i)>0
        s(i)=1;
    else
        s(i)=-1;
    end
end
Q=(1/4*m)*s'*(B{1}+B{1}')*s;
while finetune_increase>0
    for i=1:length(s)
        s(i)=s(i)*-1;
        Q_v(i)=(1/4*m)*s'*(B{1}+B{1}')*s;
        s(i)=s(i)*-1;
    end
    [max_Q,index]=max(Q_v,[],'all','linear'); finetune_increase=max_Q-Q;
    if finetune_increase>0
        s(index)=s(index)*-1;
        Q=max_Q;
    end
end
for i=1:length(s)
    if s(i)==1
        modules{2}(i)=i;
    else
        modules{3}(i)=i;
    end
end

%Modularity submatrix
for z=2:64
    proceed=0;
    if rem(z,2)==0 
        if sum(modules{z/2})>0
            proceed=1;
        end
    end
    if rem(z,2)==1
        if sum(modules{(z-1)/2})>0
            proceed=1;
        end
    end
    if proceed==1;    
        for i=1:length(adj_dir_binary)
            for j=1:length(adj_dir_binary)
                if (modules{z}(i)==i) && (modules{z}(j)==j) 
                    for k=1:length(adj_dir_binary)
                        row_coloumn_summed(i)=row_coloumn_summed(i)+B{1}(i,k)+B{1}(k,i);
                    end
                    I=sym(i); J=sym(j);
                    B{z}(i,j)=B{1}(i,j)-(1/2)*kroneckerDelta(I,J)*row_coloumn_summed(i);
                end
            end
        end
        [eigenvectors,eigenvalues]=eig(B{z}+B{z}');
        [max_eigenvalue,linear_index]=max(eigenvalues,[],'all','linear'); 
        [row,col] = ind2sub(size(eigenvalues),linear_index); 
        s=eigenvectors(:,row); 
        for i=1:length(s)
            if s(i)>0
                s(i)=1;
            else
                s(i)=-1;
            end
        end
        delta_Q=(1/4*m)*s'*(B{z}+B{z}')*s;
        finetune_increase=1;
        while finetune_increase>0
            for i=1:length(s)
                s(i)=s(i)*-1;
                Q_v(i)=(1/4*m)*s'*(B{z}+B{z}')*s;
                s(i)=s(i)*-1;
            end
            [max_Q,index]=max(Q_v,[],'all','linear'); finetune_increase=max_Q-delta_Q;
            if finetune_increase>0
                s(index)=s(index)*-1;
                delta_Q=max_Q;
            end
        end
        for i=1:length(s)
            if s(i)==1
                modules{2*z}(i)=i;
            else
                modules{(2*z)+1}(i)=i;
            end
        end
    end
end

end