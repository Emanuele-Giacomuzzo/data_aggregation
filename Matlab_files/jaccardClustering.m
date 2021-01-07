function[adj_cluster_jaccard]=jaccardClustering(adj_dir_binary,threshold,link_percentage)

cd jaccard_clustering;

jaccard_v = pdist (adj_dir_binary, 'jaccard');
jaccard_average = linkage(jaccard_v, 'average');
cluster_identity_jac =cluster(jaccard_average,'cutoff',threshold);

adj_cluster = linkingClusters(adj_dir_binary,cluster_identity,link_percentage)

cluster_size_jac=clustersize(cluster_identity_jac);
possible_connections=possibleconnections(cluster_size_jac);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity_jac);

adj_cluster_jaccard=clusterslinkage(adj_dir_binary,cluster_identity_jac,realised_connections,possible_connections,link_percentage);

cd ..;

end