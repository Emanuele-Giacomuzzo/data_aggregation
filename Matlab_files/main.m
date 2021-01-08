clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/Data_aggregation/Matlab_files';
load ../data/A; %the species in the rows are eaten by the species in the coloumns. A: directed weighted network.
load ../data/node_names;
load ../data/REGE3.mat; %compute the REGE matrix with the software UCINET

network=digraph(A); 
n=length(A);

nBC=centrality(network,'betweenness')/[(n-1)*(n-2)/2];
nwDC=weightedDegree(A)/(n-1);

A_uw=toundirected(A); network_U=graph(A_uw);
nCC=centrality(network_U,'closeness')*(n-1);
nDC=centrality(network_U,'degree')/(n-1);

[s,cs,ns] = status_index(A);
[k,kbu,ktd,kdir,kindir]=keystoneIndices(A);
[TI_species,TI_species_ratio]=topologicalImportance(A,3);
[TO,TO_ratio]=topologicalOverlap(A,3,0.01);

cluster_nr_patternModularity=patternModularity(A);
cluster_nr_densityModularity=densityModularity(A);
%A_patternModularity=linkingClusters(A,cluster_nr_patternModularity,5);
%A_densityModularity=linkingClusters(A,cluster_nr_densityModularity,5);


[cluster_nr_DC{1},A_DC{1}]=hierarchicalClustering(jaccard,degree);
[cluster_nr_CC{1},A_CC{1}]=hierarchicalClustering(jaccard,CC);
[cluster_nr_BC{1},A_BC{1}]=hierarchicalClustering(jaccard,BC);
[cluster_nr_s{1},A_s{1}]=hierarchicalClustering(jaccard,s);
[cluster_nr_cs{1},A_cs{1}]=hierarchicalClustering(jaccard,cs);
[cluster_nr_ns{1},A_ns{1}]=hierarchicalClustering(jaccard,ns);
[cluster_nr_k{1},A_k{1}]=hierarchicalClustering(jaccard,k);
[cluster_nr_kbu{1},A_kbu{1}]=hierarchicalClustering(jaccard,kbu);
[cluster_nr_ktd{1},A_ktd{1}]=hierarchicalClustering(jaccard,ktd);
[cluster_nr_kdir{1},A_kdir{1}]=hierarchicalClustering(jaccard,kdir);
[cluster_nr_kindir{1},A_kindir{1}]=hierarchicalClustering(jaccard,kindir);
[cluster_nr_TI{1},A_TI{1}]=hierarchicalClustering(jaccard,TI);
[cluster_nr_TIratio{1},A_TIratio{1}]=hierarchicalClustering(jaccard,TI_ratio);
[cluster_nr_TO{1},A_TO{1}]=hierarchicalClustering(jaccard,TO);
[cluster_nr_TOratio,A_TOratio{1}]=hierarchicalClustering(jaccard,TO_ratio);

[cluster_nr_DC{2},A_DC{2}]=hierarchicalClustering(rege,degree);
[cluster_nr_CC{2},A_CC{2}]=hierarchicalClustering(rege,CC);
[cluster_nr_BC{2},A_BC{2}]=hierarchicalClustering(rege,BC);
[cluster_nr_s{2},A_s{2}]=hierarchicalClustering(rege,s);
[cluster_nr_cs{2},A_cs{2}]=hierarchicalClustering(rege,cs);
[cluster_nr_ns{2},A_ns{2}]=hierarchicalClustering(rege,ns);
[cluster_nr_k{2},A_k{2}]=hierarchicalClustering(rege,k);
[cluster_nr_kbu{2},A_kbu{2}]=hierarchicalClustering(rege,kbu);
[cluster_nr_ktd{2},A_ktd{2}]=hierarchicalClustering(rege,ktd);
[cluster_nr_kdir{2},A_kdir{2}]=hierarchicalClustering(rege,kdir);
[cluster_nr_kindir{2},A_kindir{2}]=hierarchicalClustering(rege,kindir);
[cluster_nr_TI{2},A_TI{2}]=hierarchicalClustering(rege,TI);
[cluster_nr_TIratio{2},A_TIratio{2}]=hierarchicalClustering(rege,TI_ratio);
[cluster_nr_TO{2},A_TO{2}]=hierarchicalClustering(rege,TO);
[cluster_nr_TOratio{2},A_TOratio{2}]=hierarchicalClustering(rege,TO_ratio);














































