function[A_clusters,centrality_clusters,clusterID,best_link,best_th]=guidedClustering(A,branches)

best_W=0;
for i=0.01:0.05:1 %i:link percentage
    for j=0.01:0.05:1 %threshold
        %if aggregation is one of the first two 
        %    clusterID=cluster(branches ,'cutoff',i); 
        %end
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
end

%if aggregation is one of the first two
%    clusterID=cluster(branches,'cutoff',best_threshold);
%end
A_clusters=linkingClusters(A,clusterID,best_link_percentage);
centrality_clusters=calculateCentrality(A_clusters,centrality_type);
centrality_nodes=centralityNodes(centrality_clusters, clusterID);

end