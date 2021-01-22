clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';
A=readmatrix("../data/adjacency_matrix.txt"); n=length(A); network=digraph(A); network_U=graph(toundirected(A));
load('../data/node_names.mat');
centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"k";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"]; c=length(centralities);
aggregations=["Jaccard_similarity";"Rege_similarity";"Pattern_modularity";"Density_modularity";"Group_model"]; a=length(aggregations);

%Centrality nodes in original food web
nDC = centrality(network_U,'degree')/(n-1);
nwDC = weightedDegree(A)/(n-1);
nCC = centrality(network_U,'closeness')*(n-1);
nBC = centrality(network,'betweenness')/((n-1)*(n-2)/2);
[s,cs,ns] = statusIndices(A); 
[k,kbu,ktd,kdir,kindir] = keystoneIndices(A);
TI = topologicalImportance(A,3);
STO = topologicalOverlap(A,3,0.02,0.2,0.02);
TP = trophicPosition(A);

%Cluster creation
branches_jaccard = findBranches(A,"jaccard");
rege_similarity=readmatrix("../data/REGE3");
branches_rege = findBranches(A,"rege",rege_similarity);
clusterID_jaccard=cluster(branches_jaccard,'cutoff',0.01);
clusterID_rege=cluster(branches_rege,'cutoff',0.01);
clusterID_patternModularity=patternModularity(A);
clusterID_densityModularity=densityModularity(A);
clusterID_groups=readmatrix("../data/group_model_results");
cluster_ID=[clusterID_jaccard clusterID_rege clusterID_patternModularity clusterID_densityModularity clusterID_groups];

%Cluster linkage
best_link=double.empty;
best_weight=string.empty;
for i=1:a
    for j=1:c
        [best_link(j,i),best_weight(j,i)] = bestLinking(A,cluster_ID(:,i),centralities(j),eval(centralities(j)))
    end
end

%Centrality nodes in clustered food web 
centrality_clusters=cell(c,a);
centrality_nodes=cell(c,a);
for i=1:a
    for j=1:c
        centrality_clusters{j,i}=centralityClusters(A_clustered{j,i},centralities(j));
        centrality_nodes{j,i}=centralityNodes(centrality_clusters{j,i}, cluster_ID(:,i));
    end
end

%Kendall test
W=double.empty;
for i=1:a
    for j=1:c
        check=[eval(centralities(j)) centrality_nodes{j,i}]; %here
        W(j,i)=KendallCoef(check);
    end
end
rs=((a*W)-1)/(a-1);