function[clusterID,A_clusters,centrality_nodes]=bestClustering(A,branches,centrality_type,centrality_original)
%This function tells us what is (1) the threshold to which we should cut
%the dendrogrma and the (1) link percentage we should consider to connect
%two different clusters. 
A_db=tounweighted(A);

best_W=0;
for j=0.01:0.05:1
    for i=0.01:0.05:1
        clusterID=cluster(branches ,'cutoff',i);
        A_clusters=linkingClusters(A,clusterID,j);
        
        centrality_clusters=calculateCentrality(A_clusters,centrality_type); 
        centrality_nodes=centralityNodes(centrality_clusters, clusterID);
        
        centrality_compare=[centrality_original, centrality_nodes];
        W = KendallCoef(centrality_compare);
        if W > best_W best_W=W; best_threshold=i; best_link_percentage=j; end
    end
end 

clusterID=cluster(branches,'cutoff',best_threshold);
cd ..; A_clusters=linkingClusters(A,clusterID,best_link_percentage);
cd hierarchical_clustering;
centrality_clusters=calculateCentrality(A_clusters,centrality_type); 
centrality_nodes=centralityNodes(centrality_clusters, clusterID);

end