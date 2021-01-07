function [adj_cluster] = linkingClusters(adj_dir_binary,cluster_identity,link_percentage)

cd linking_clusters;

cluster_size=clustersize(cluster_identity);
possible_connections=possibleconnections(cluster_size);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity);
adj_cluster=clusterslinkage(adj_dir_binary,cluster_identity,realised_connections,possible_connections,link_percentage);

cd ..;

end