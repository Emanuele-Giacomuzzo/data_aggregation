function [adj_cluster] = linkingClusters(A,cluster_identity,link_percentage)

A_db=tounweighted(A);

cd linking_clusters;

cluster_size=clustersize(cluster_identity);
possible_connections=possibleconnections(cluster_size);
realised_connections=realisedconnections(A_db,cluster_identity);
adj_cluster=clusterslinkage(A_db,cluster_identity,realised_connections,possible_connections,link_percentage);

cd ..;

end