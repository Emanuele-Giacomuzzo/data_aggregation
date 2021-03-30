function[B]=modularitymatrix(adj_dir_binary,indegree,outdegree,m)

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        B(j,i)=adj_dir_binary(j,i)-((indegree(j)*outdegree(i))/m);
    end
end

end