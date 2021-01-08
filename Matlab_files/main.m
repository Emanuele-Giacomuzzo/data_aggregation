%Modularity maximisation is quiet a slow process and it could take a couple
%of minutes for the program to run. Just be patient. 

%Set up workspace
clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/Data_aggregation/Matlab_files';
load ../data/adj_dir_weight; %the species in the rows are eaten by the species in the coloumns
load ../data/node_names;
load ../data/REGE3.mat; %compute the REGE matrix with the software UCINET
%Transform network 
adj_dir_binary=tounweighted(adj_dir_weight); network_dir=digraph(adj_dir_weight);
adj_und_weight=toundirected(adj_dir_weight); network_und=graph(adj_und_weight);
adj_und_binary=toundirected(adj_dir_binary);
n=length(adj_dir_weight);
%Centrality indices
degree=centrality(network_und,'degree')/(n-1);
weighted_degree=weightedDegree(adj_dir_weight)/(n-1);
closeness=centrality(network_und,'closeness')*(n-1);
betweenness=centrality(network_dir,'betweenness')/[(n-1)*(n-2)/2];
[status,controstatus,net_status] = status_index(network_dir);
[k,kbu,ktd,kdir,kindir]=keystoneIndices(adj_dir_binary);
[TI_species,TI_species_ratio]=topologicalImportance(adj_und_binary,3);
[overlap,overlap_ratio]=topologicalOverlap(adj_und_binary,adj_dir_weight,network_und,3,0.01);
%Modularity maximisation
cluster_identity_patternModularity=patternBasedModularity(adj_dir_binary,adj_dir_weight);
cluster_identity_densityModularity=densityBasedModularity(adj_dir_weight, adj_dir_binary);
%adj_patternModularity=linkingClusters(adj_dir_binary,cluster_identity_patternModularity,5);
%adj_densityModularity=linkingClusters(adj_dir_binary,cluster_identity_densityModularity,5);


[cluster_identity_DC{1},adj_DC{1}]=hierarchicalClustering(jaccard,degree);
[cluster_identity_CC{1},adj_CC{1}]=hierarchicalClustering(jaccard,closeness);
[cluster_identity_BC{1},adj_BC{1}]=hierarchicalClustering(jaccard,betweenness);
[cluster_identity_s{1},adj_s{1}]=hierarchicalClustering(jaccard,status);
[cluster_identity_cs{1},adj_cs{1}]=hierarchicalClustering(jaccard,controstatus);
[cluster_identity_ns{1},adj_ns{1}]=hierarchicalClustering(jaccard,net_status);
[cluster_identity_k{1},adj_k{1}]=hierarchicalClustering(jaccard,k);
[cluster_identity_kbu{1},adj_kbu{1}]=hierarchicalClustering(jaccard,kbu);
[cluster_identity_ktd{1},adj_ktd{1}]=hierarchicalClustering(jaccard,ktd);
[cluster_identity_kdir{1},adj_kdir{1}]=hierarchicalClustering(jaccard,kdir);
[cluster_identity_kindir{1},adj_kindir{1}]=hierarchicalClustering(jaccard,kindir);
[cluster_identity_TI{1},adj_TI{1}]=hierarchicalClustering(jaccard,TI);
[cluster_identity_TIratio{1},adj_TIratio{1}]=hierarchicalClustering(jaccard,TI_ratio);
[cluster_identity_TO{1},adj_TO{1}]=hierarchicalClustering(jaccard,overlap);
[cluster_identity_TOratio,adj_TOratio{1}]=hierarchicalClustering(jaccard,overlap_ratio);

[cluster_identity_DC{2},adj_DC{2}]=hierarchicalClustering(rege,degree);
[cluster_identity_CC{2},adj_CC{2}]=hierarchicalClustering(rege,closeness);
[cluster_identity_BC{2},adj_BC{2}]=hierarchicalClustering(rege,betweenness);
[cluster_identity_s{2},adj_s{2}]=hierarchicalClustering(rege,status);
[cluster_identity_cs{2},adj_cs{2}]=hierarchicalClustering(rege,controstatus);
[cluster_identity_ns{2},adj_ns{2}]=hierarchicalClustering(rege,net_status);
[cluster_identity_k{2},adj_k{2}]=hierarchicalClustering(rege,k);
[cluster_identity_kbu{2},adj_kbu{2}]=hierarchicalClustering(rege,kbu);
[cluster_identity_ktd{2},adj_ktd{2}]=hierarchicalClustering(rege,ktd);
[cluster_identity_kdir{2},adj_kdir{2}]=hierarchicalClustering(rege,kdir);
[cluster_identity_kindir{2},adj_kindir{2}]=hierarchicalClustering(rege,kindir);
[cluster_identity_TI{2},adj_TI{2}]=hierarchicalClustering(rege,TI);
[cluster_identity_TIratio{2},adj_TIratio{2}]=hierarchicalClustering(rege,TI_ratio);
[cluster_identity_TO{2},adj_TO{2}]=hierarchicalClustering(rege,overlap);
[cluster_identity_TOratio{2},adj_TOratio{2}]=hierarchicalClustering(rege,overlap_ratio);














































