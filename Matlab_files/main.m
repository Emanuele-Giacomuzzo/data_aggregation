clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/Data_aggregation/Matlab_files';
load ../data/A;   
load ../data/node_names;
load ../data/REGE3.mat; %compute the REGE matrix with the software UCINET

n=length(A); 
network=digraph(A);
network_U=graph(toundirected(A));

nDC = centrality(network_U,'degree')/(n-1);
nwDC = weightedDegree(A)/(n-1);
nCC = centrality(network_U,'closeness')*(n-1);
nBC = centrality(network,'betweenness')/[(n-1)*(n-2)/2];
[s,cs,ns] = statusIndices(A);
[k,kbu,ktd,kdir,kindir] = keystoneIndices(A);
[TI_species,TI_species_ratio] = topologicalImportance(A,3);
[TO,TO_ratio] = topologicalOverlap(A,3,0.01);

clusterID_patternModularity = patternModularity(A);
clusterID_densityModularity = densityModularity(A);
%A_patternModularity = linkingClusters(A,clusterID_patternModularity,5);
%A_densityModularity = linkingClusters(A,clusterID_densityModularity,5);


[clusterID_nDC{1},A_nDC{1}] = hierarchicalClustering(jaccard,nDC);
[clusterID_nDC{1},A_nwDC{1}] = hierarchicalClustering(jaccard,nwDC);
[clusterID_nCC{1},A_nCC{1}] = hierarchicalClustering(jaccard,nCC);
[clusterID_nBC{1},A_nBC{1}] = hierarchicalClustering(jaccard,nBC);
[clusterID_s{1},A_s{1}] = hierarchicalClustering(jaccard,s);
[clusterID_cs{1},A_cs{1}] = hierarchicalClustering(jaccard,cs);
[clusterID_ns{1},A_ns{1}] = hierarchicalClustering(jaccard,ns);
[clusterID_k{1},A_k{1}] = hierarchicalClustering(jaccard,k);
[clusterID_kbu{1},A_kbu{1}]=hierarchicalClustering(jaccard,kbu);
[clusterID_ktd{1},A_ktd{1}]=hierarchicalClustering(jaccard,ktd);
[clusterID_kdir{1},A_kdir{1}]=hierarchicalClustering(jaccard,kdir);
[clusterID_kindir{1},A_kindir{1}]=hierarchicalClustering(jaccard,kindir);
[clusterID_TI{1},A_TI{1}]=hierarchicalClustering(jaccard,TI);
[clusterID_TIratio{1},A_TIratio{1}]=hierarchicalClustering(jaccard,TI_ratio);
[clusterID_TO{1},A_TO{1}]=hierarchicalClustering(jaccard,TO);
[clusterID_TOratio,A_TOratio{1}]=hierarchicalClustering(jaccard,TO_ratio);

[clusterID_nDC{2},A_nDC{2}]=hierarchicalClustering(rege,nDC);
[clusterID_nDC{2},A_nwDC{2}]=hierarchicalClustering(rege,nwDC);
[clusterID_nCC{2},A_nCC{2}]=hierarchicalClustering(rege,nCC);
[clusterID_nBC{2},A_nBC{2}]=hierarchicalClustering(rege,nBC);
[clusterID_s{2},A_s{2}]=hierarchicalClustering(rege,s);
[clusterID_cs{2},A_cs{2}]=hierarchicalClustering(rege,cs);
[clusterID_ns{2},A_ns{2}]=hierarchicalClustering(rege,ns);
[clusterID_k{2},A_k{2}]=hierarchicalClustering(rege,k);
[clusterID_kbu{2},A_kbu{2}]=hierarchicalClustering(rege,kbu);
[clusterID_ktd{2},A_ktd{2}]=hierarchicalClustering(rege,ktd);
[clusterID_kdir{2},A_kdir{2}]=hierarchicalClustering(rege,kdir);
[clusterID_kindir{2},A_kindir{2}]=hierarchicalClustering(rege,kindir);
[clusterID_TI{2},A_TI{2}]=hierarchicalClustering(rege,TI);
[clusterID_TIratio{2},A_TIratio{2}]=hierarchicalClustering(rege,TI_ratio);
[clusterID_TO{2},A_TO{2}]=hierarchicalClustering(rege,TO);
[clusterID_TOratio{2},A_TOratio{2}]=hierarchicalClustering(rege,TO_ratio);














































