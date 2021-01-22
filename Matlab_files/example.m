clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';

A=readmatrix("../data/adjacency_matrix.txt");

nwDC = weightedDegree(A)/(length(A)-1);
cluster_ID=readmatrix("../data/group_model_results");
[A_clusters_b,best_link] = wireWeb(A,cluster_ID,'nwDC',nwDC); %here
[A_clusters_min,A_clusters_mean,A_clusters_max,A_clusters_sum] = linkClustersWeight(A,A_clusters_b,cluster_ID);
centrality_clusters=centralityClusters(A_clusters_b,"nwDC");
centrality_nodes=centralityNodes(centrality_clusters, cluster_ID);