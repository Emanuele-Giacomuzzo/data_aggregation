clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/Data_aggregation/Matlab_files';
load ../data/adj_dir_weight; %the species in the rows are eaten by the species in the coloumns
load ../data/node_names;
load ../data/REGE3.mat; %compute the REGE matrix with the software UCINET

adj_dir_binary=tounweighted(adj_dir_weight);
adj_und_weight=toundirected(adj_dir_weight);
adj_und_binary=toundirected(adj_dir_binary);
network_dir=digraph(adj_dir_weight);
network_und=graph(adj_und_weight);
n=length(adj_dir_weight);

degree=centrality(network_und,'degree')/(n-1);
weighted_degree=weightedDegree(adj_dir_weight)/(n-1);
closeness=centrality(network_und,'closeness')*(n-1);
betweenness=centrality(network_dir,'betweenness')/[(n-1)*(n-2)/2];
[status,controstatus,net_status] = status_index(network_dir);
[k,kbu,ktd,kdir,kindir]=keystoneIndices(adj_dir_binary);
[TI_species,TI_species_ratio]=topologicalImportance(adj_und_binary,3);
[overlap,overlap_ratio]=topologicalOverlap(adj_und_binary,adj_dir_weight,network_und,3,0.01);

cluster_identity_jac=jaccardClustering(adj_dir_binary,0.01,50);
adj_jaccard=linkingClusters(adj_dir_binary,cluster_identity_jac,5);

cluster_identity_rege=regeClustering(REGE3, 0.01, 50);
adj_rege=linkingClusters(adj_dir_binary,cluster_identity_rege,5);

cluster_identity_patternModularity=patternBasedModularity(adj_dir_binary,adj_dir_weight);
adj_patternModularity=linkingClusters(adj_dir_binary,cluster_identity_patternModularity,5);

cluster_identity_densityModularity=densityBasedModularity(adj_dir_weight, adj_dir_binary);
adj_densityModularity=linkingClusters(adj_dir_binary,cluster_identity_densityModularity,5);