function [A_clusters,centrality_nodes,best_link_percentage] = otherClustering(A,centrality_type,centrality_original,clusterID)
cd hierarchical_clustering;

best_W=0;
for i=0.05:0.05:1
    A_clusters=linkingClusters(A,clusterID,i); 
    centrality_clusters=calculateCentrality(A_clusters,centrality_type); 
    centrality_nodes=centralityNodes(centrality_clusters, clusterID);
    centrality_compare=[centrality_original, centrality_nodes];
    W = KendallCoef(centrality_compare);
    if W > best_W 
        best_W=W;
        best_link_percentage=i; 
    end
end

A_clusters=linkingClusters(A,clusterID,best_link_percentage);
centrality_clusters=calculateCentrality(A_clusters,centrality_type);
centrality_nodes=centralityNodes(centrality_clusters, clusterID);

cd ..;
end