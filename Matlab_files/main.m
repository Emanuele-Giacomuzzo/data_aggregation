clc,clear; cd '/Users/ema/Google Drive/Github/Data_aggregation/Matlab_files';
A=readmatrix("../data/adjacency_matrix.txt");
n=length(A);
network=digraph(A);
network_U=graph(toundirected(A));

centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"k";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"];
c=length(centralities);
aggregations=["Jaccard similarity HC";"Rege similarity HC";"Pattern modularity";"Density modularity";"Group model"];
a=length(aggregations);

clusterID_patternModularity=patternModularity(A);
clusterID_densityModularity=densityModularity(A);
clusterID_groups=readmatrix("../data/group_model_results");

nDC(:,1) = centrality(network_U,'degree')/(n-1);
nwDC(:,1) = weightedDegree(A)/(n-1);
nCC(:,1) = centrality(network_U,'closeness')*(n-1);
nBC(:,1) = centrality(network,'betweenness')/((n-1)*(n-2)/2);
[s(:,1),cs(:,1),ns(:,1)] = statusIndices(A); 
[k(:,1),kbu(:,1),ktd(:,1),kdir(:,1),kindir(:,1)] = keystoneIndices(A);
[TI(:,1),TI_ratio(:,1)] = topologicalImportance(A,3);
[STO(:,1),STO_ratio(:,1)] = topologicalOverlap(A,3,0.02,0.2,0.02);
TP(:,1) = trophicPosition(A);

rege_similarity=readmatrix("../data/REGE3");
cluster_ID=double.empty(a,c,n,0); 
cluster_centrality=double.empty(a,c,n,0); 
cluster_A=double.empty; 
best_th=double.empty; 
best_link=double.empty;
branches=double.empty;
for i=1:a
    for j=1:c
        branches(i) = createDendrogram(aggregations(j));
        [cluster_A(i,j),cluster_centrality(i,j),cluster_ID(i,j),best_link(i,j),best_th(i,j)] = guidedClustering(A,aggregations(j),centrality(j),rege_similarity);
    end
end

W=zeros(c,5);
for i=1:c
    centrality=eval(centralities(i));
    for j=2:6
        check=[centrality(:,1) centrality(:,j)]; %here
        W(i,j-1)=KendallCoef(check);
    end
end
rs=((a*W)-1)/(a-1);

h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";