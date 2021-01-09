function[centrality_nodes]=centralityspecies(centrality_clusters, cluster_identity)

%It is useful to go from the centrality of the clustered nodes to giving
%the same centrality to the single nodes. 

centrality_nodes=zeros(length(cluster_identity),1);

for i=1:length(centrality_clusters)
    for k=1:length(centrality_nodes)
        if cluster_identity(k)==i
            centrality_nodes(k)=centrality_clusters(i);
        end
    end
end

end