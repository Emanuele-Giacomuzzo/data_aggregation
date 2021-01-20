clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';

%Basic parameters
A=readmatrix("../data/adjacency_matrix.txt");
n=length(A);
network=digraph(A);
network_U=graph(toundirected(A));
centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"k";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"];
c=length(centralities);
aggregations=["Jaccard_similarity";"Rege_similarity";"Pattern_modularity";"Density_modularity";"Group_model"];
a=length(aggregations);

%Initialise
centrality_single_clusters=cell(c,a);
cluster_centrality=cell(c,a);
cluster_A=double.empty; 
best_link=double.empty;
W=double.empty;
z=0;

%Centrality
nDC(:,1) = centrality(network_U,'degree')/(n-1);
nwDC(:,1) = weightedDegree(A)/(n-1);
nCC(:,1) = centrality(network_U,'closeness')*(n-1);
nBC(:,1) = centrality(network,'betweenness')/((n-1)*(n-2)/2);
[s(:,1),cs(:,1),ns(:,1)] = statusIndices(A); 
[k(:,1),kbu(:,1),ktd(:,1),kdir(:,1),kindir(:,1)] = keystoneIndices(A);
[TI(:,1),TI_ratio(:,1)] = topologicalImportance(A,3);
[STO(:,1),STO_ratio(:,1)] = topologicalOverlap(A,3,0.02,0.2,0.02);
TP(:,1) = trophicPosition(A);

%Create clusters
branches_jaccard = findBranches(A,"jaccard");
rege_similarity=readmatrix("../data/REGE3");
branches_rege = findBranches(A,"rege",rege_similarity);
clusterID_jaccard=cluster(branches_jaccard,'cutoff',0.01);
clusterID_rege=cluster(branches_rege,'cutoff',0.01);
clusterID_patternModularity=patternModularity(A);
clusterID_densityModularity=densityModularity(A);
clusterID_groups=readmatrix("../data/group_model_results");
cluster_ID=[clusterID_jaccard clusterID_rege clusterID_patternModularity clusterID_densityModularity clusterID_groups];

%Link clusters
for i=1:a
    for j=1:c
        [cluster_A{j,i},best_link(j,i)] = wireWeb(A,cluster_ID(:,i),centralities(j),eval(centralities(j)));
    end
end

%Centrality clusters
for i=1:a
    for j=1:c
        centrality_single_clusters{j,i}=centralityClusters(cluster_A{j,i},centralities(j));
        cluster_centrality{j,i}=centralityNodes(centrality_single_clusters{j,i}, cluster_ID(:,i));
    end
end

%Kendall testr
for i=1:a
    for j=1:c
        check=[eval(centralities(j)) cluster_centrality{j,i}];
        W(j,i)=KendallCoef(check);
    end
end
rs=((a*W)-1)/(a-1);

%Heatmap
h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";