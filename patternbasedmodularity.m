%function [] = patternbasedmodularity()

indegree=zeros(length(adj_dir_binary),1);
outdegree=zeros(length(adj_dir_binary),1);
c_out=zeros(length(adj_dir_binary));
modularity=0;
node_identity=zeros(length(adj_dir_binary), 1);
kl_kl_minus_one=0;

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
for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        for k=1:length(adj_dir_binary) 
            if (adj_dir_binary(i,k)>0) && (adj_dir_binary(j,k)>0)
                c_out(i,j)=c_out(i,j)+1;
            end
        end
    end
end
for l=1:length(adj_dir_binary)
    kl_kl_minus_one=kl_kl_minus_one+(indegree(l)*(indegree(l)-1));
end
for i=1:length(adj_dir_binary),; 
    for j=1:length(adj_dir_binary),;
        mi=sym(node_identity(i)); mj=sym(node_identity(j));
        modularity=modularity+{{[c_out(i,j)/kl_kl_minus_one-outdegree(i)]-[outdegree(j)/(sum(indegree)^2)]}*kroneckerDelta(mi,mj)};
    end
end




%end