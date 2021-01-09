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

for i=1:2
if i==1 similarity="jaccard"; elseif i==2 similarity="rege"; end
[clusterID_nDC{i},A_nDC{i}] = hierarchicalClustering(A,similarity,"nDC",nDC); %ok
[clusterID_nDC{i},A_nwDC{i}] = hierarchicalClustering(A,similarity,"nwDC",nwDC);
[clusterID_nCC{i},A_nCC{i}] = hierarchicalClustering(A,similarity,"nCC",nCC);
[clusterID_nBC{i},A_nBC{i}] = hierarchicalClustering(A,similarity,"nBC",nBC);
[clusterID_s{i},A_s{i}] = hierarchicalClustering(A,similarity,"s",s);
[clusterID_cs{i},A_cs{i}] = hierarchicalClustering(A,similarity,"cs",cs);
[clusterID_ns{i},A_ns{i}] = hierarchicalClustering(A,similarity,"ns",ns);
[clusterID_k{i},A_k{i}] = hierarchicalClustering(A,similarity,"k",k);
[clusterID_kbu{i},A_kbu{i}]=hierarchicalClustering(A,similarity,"kbu",kbu);
[clusterID_ktd{i},A_ktd{i}]=hierarchicalClustering(A,similarity,"ktd",ktd);
[clusterID_kdir{i},A_kdir{i}]=hierarchicalClustering(A,similarity,"kdir",kdir);
[clusterID_kindir{i},A_kindir{i}]=hierarchicalClustering(A,similarity,"kindir",kindir);
[clusterID_TI{i},A_TI{i}]=hierarchicalClustering(A,similarity,"TI",TI);
[clusterID_TIratio{i},A_TIratio{i}]=hierarchicalClustering(A,similarity,"TI_ratio",TI_ratio);
[clusterID_TO{i},A_TO{i}]=hierarchicalClustering(A,similarity,"TO",TO);
[clusterID_TOratio{i},A_TOratio{i}]=hierarchicalClustering(A,similarity,"TO_ratio",TO_ratio);
end