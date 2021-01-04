function [centrality_we_degree] = weightedDegree(adj_dir_weight)

n=length(adj_dir_weight);
centrality_we_degree=zeros(n,1);

for i=1:n
    for j=1:n
        centrality_we_degree(i)=centrality_we_degree(i)+adj_dir_weight(i,j);
    end
end

end

