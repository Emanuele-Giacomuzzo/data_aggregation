function[outdegree]=nodeoutdegree(adj_dir_binary)

outdegree=zeros(length(adj_dir_binary),1);

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if adj_dir_binary(i,j)>0 
            outdegree(j)=outdegree(j)+1;
        end
    end
end

end