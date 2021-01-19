function [A_clusters,best_link] = wireWeb(A,cluster_ID,centrality,centrality_original)

best_W=0;
for i=0.01:0.05:1 %i:link percentage
        A_clusters=linkingClusters(A,cluster_ID,i); 
        centrality_clusters=calculateCentrality(A_clusters,centrality); 
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