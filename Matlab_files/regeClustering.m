function[adj_cluster_rege]=regeClustering(threshold,link_percentage)

load ../data/REGE3.mat;
cd rege_clustering;

REGE3_norm=REGE3/1000;
REGE3_dis=similarityToDissimilarity(REGE3_norm);

rege_v=squareform(REGE3_dis);
rege_average = linkage(rege_v, 'average');
cluster_identity_rege =cluster(rege_average,'cutoff',threshold);
cluster_size_rege=clustersize(cluster_identity_rege);
possible_connections=possibleconnections(cluster_size_rege);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity_rege);

adj_cluster_rege=clusterslinkage(adj_dir_binary,cluster_identity_rege,realised_connections,possible_connections,link_percentage);

cd ..;

end