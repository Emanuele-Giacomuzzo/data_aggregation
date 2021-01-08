function[cluster_identity,adj]=bestClustering(linked)

best_p=0;
for j=0.01:0.05:1
for i=0.01:0.05:1
cluster_identity=cluster(linked ,'cutoff',i);
adj=linkingClusters(adj_dir_binary,cluster_identity,j);
something=rightNetwork();
centrality_nodes=centralityspecies(centrality_clusters, cluster_identity);
centrality_compare=[centrality, centrality_nodes];
p = friedman(centrality_compare,1,'off');
if p > best_p best_p=p; best_threshold=i; best_link_percentage=j; end
end
end

cluster_identity=cluster(linked ,'cutoff',best_threshold);
adj=linkingClusters(adj_dir_binary,cluster_identity,best_link_percentage);

end