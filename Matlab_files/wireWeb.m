function [A_clusters,best_link,centrality_nodes] = wireWeb(A,cluster_ID,centrality_type,centrality_original) 

best_W=0;
for i=0.005:0.005:1 %i=link percentage
        A_clusters=linkingClusters(A,cluster_ID,i);
        centrality_clusters=centralityClusters(A_clusters,centrality_type); 
        centrality_nodes=centralityNodes(centrality_clusters, cluster_ID);
        centrality_compare=[centrality_original, centrality_nodes];
        W = KendallCoef(centrality_compare);
        if W > best_W 
            best_W=W;
            best_link=i;
        end
end

A_clusters=linkingClusters(A,cluster_ID,best_link);

end