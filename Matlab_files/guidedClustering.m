function[A_clusters,centrality_nodes,clusterID,best_link,best_threshold]=guidedClustering(A,branches,aggregation)
%I need to give it the cluster ID for the last three aggregations

A_clusters=linkingClusters(A,clusterID,best_link);
centrality_clusters=calculateCentrality(A_clusters,centrality_type);
centrality_nodes=centralityNodes(centrality_clusters, clusterID);

end