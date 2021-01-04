function[centrality_nodes]=centralityspecies(centrality_clusters, cluster_identity)

centrality_nodes=zeros(length(cluster_identity),1);

for i=1:length(centrality_clusters)
    for k=1:length(centrality_nodes)
        if cluster_identity(k)==i
            centrality_nodes(k)=centrality_clusters(i);
        end
    end
end

end