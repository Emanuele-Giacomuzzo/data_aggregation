function[cluster_nr,adj]=bestClustering(linked)

best_p=0;
for j=0.01:0.05:1
for i=0.01:0.05:1
cluster_nr=cluster(linked ,'cutoff',i);
adj=linkingClusters(adj_dir_binary,cluster_nr,j);
something=rightNetwork();
centrality_nodes=centralityspecies(centrality_clusters, cluster_nr);
centrality_compare=[centrality, centrality_nodes];
p = friedman(centrality_compare,1,'off');
if p > best_p best_p=p; best_threshold=i; best_link_percentage=j; end
end
end

cluster_nr=cluster(linked ,'cutoff',best_threshold);
adj=linkingClusters(adj_dir_binary,cluster_nr,best_link_percentage);

end