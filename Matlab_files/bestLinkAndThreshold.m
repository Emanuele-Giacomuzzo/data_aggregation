function [best_link,best_threshold] = bestLinkAndThreshold(A,clusterID,aggregation,branches)

best_W=0;
for i=0.01:0.05:1 %i:link percentage
    for j=0.01:0.05:1 %threshold
        if aggregation=="Jaccard similarity HC" || aggregation=="Rege similarity HC"
            clusterID=cluster(branches ,'cutoff',i); 
        end
    A_clusters=linkingClusters(A,clusterID,i); 
    centrality_clusters=calculateCentrality(A_clusters,centrality); 
    centrality_nodes=centralityNodes(centrality_clusters, clusterID);
    centrality_compare=[centrality_original, centrality_nodes];
    W = KendallCoef(centrality_compare);
    if W > best_W 
        best_W=W;
        best_link=i;
        best_threshold=j;
    end
    end
end


end