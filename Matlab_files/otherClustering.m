function [A_clusters,centrality_nodes] = otherClustering(A,clustering_type,centrality_type,centrality_original,clusterID)
cd hierarchical_clustering;

best_p=0;
for i=0.05:0.05:1
    A_clusters=linkingClusters(A,clusterID,i); %here's the problem with i=5
    
    centrality_clusters=calculateCentrality(A_clusters,centrality_type); 
    centrality_nodes=centralityNodes(centrality_clusters, clusterID);
    
    centrality_compare=[centrality_original, centrality_nodes];
    p = friedman(centrality_compare,1,'off');
    if p > best_p; best_p=p; best_link_percentage=i; end
end

A_clusters=linkingClusters(A,clusterID,best_link_percentage);

centrality_clusters=calculateCentrality(A_clusters,centrality_type);
centrality_nodes=centralityNodes(centrality_clusters, clusterID);


cd ..;

end