function[indegree]=nodeindegree(adj_dir_binary)

indegree=zeros(length(adj_dir_binary),1);

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if adj_dir_binary(i,j)>0 
            indegree(j)=indegree(j)+1;
        end
    end
end

end