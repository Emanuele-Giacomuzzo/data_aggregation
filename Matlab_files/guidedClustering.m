function[A_clusters,centrality_nodes,clusterID,best_link,best_threshold]=guidedClustering(A,branches,aggregation)
    
[best_link,best_threshold] = bestLinkAndThreshold(A,clusterID,aggregation,branches);
if aggregation=="Jaccard similarity HC" || aggregation=="Rege similarity HC"
    clusterID=cluster(branches,'cutoff',best_threshold);
end
A_clusters=linkingClusters(A,clusterID,best_link);
centrality_clusters=calculateCentrality(A_clusters,centrality_type);
centrality_nodes=centralityNodes(centrality_clusters, clusterID);

end