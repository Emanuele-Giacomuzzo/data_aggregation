clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';

%Basic parameters & initalisation
A=readmatrix("../data/adjacency_matrix.txt");
load('../data/node_names.mat');
n=length(A);
network=digraph(A);
network_U=graph(toundirected(A));
centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"k";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"];
c=length(centralities);
aggregations=["Jaccard_similarity";"Rege_similarity";"Pattern_modularity";"Density_modularity";"Group_model"];
a=length(aggregations);
centrality_single_clusters=cell(c,a);
cluster_centrality=cell(c,a);
cluster_A=double.empty; 
best_link=double.empty;
W=double.empty;
z=0;

%Centrality
nDC(:,1) = centrality(network_U,'degree')/(n-1);
nDC_ratio=nDC/sum(nDC);
nwDC(:,1) = weightedDegree(A)/(n-1);
nwDC_ratio=nwDC/sum(nwDC);
nCC(:,1) = centrality(network_U,'closeness')*(n-1);
nCC_ratio=nCC/sum(nCC);
nBC(:,1) = centrality(network,'betweenness')/((n-1)*(n-2)/2);
nBC_ratio=nBC/sum(nBC);
[s(:,1),cs(:,1),ns(:,1)] = statusIndices(A); 
s_ratio=s/sum(s);
cs_ratio=cs/sum(cs);
ns_ratio=ns/sum(ns);
[k(:,1),kbu(:,1),ktd(:,1),kdir(:,1),kindir(:,1)] = keystoneIndices(A);
k_ratio=k/sum(k);
kbu_ratio=kbu/sum(kbu);
ktd_ratio=ktd/sum(ktd);
kdir_ratio=kdir/sum(kdir);
kindir_ratio=kindir/sum(kindir);
[TI(:,1),TI_ratio(:,1)] = topologicalImportance(A,3);
[STO(:,1),STO_ratio(:,1)] = topologicalOverlap(A,3,0.02,0.2,0.02);
TP(:,1) = trophicPosition(A);
TP_ratio=TP/sum(TP);
original_centralities=[nDC_ratio nwDC_ratio nCC_ratio nBC_ratio s_ratio cs_ratio ns_ratio k_ratio kbu_ratio ktd_ratio kdir_ratio kindir_ratio TI_ratio STO_ratio TP_ratio];

%Centrality heatmap
h2=heatmap(centralities,node_names,original_centralities,'Colormap',parula);
caxis(h2,[0, 1]);
h2.CellLabelFormat = '%.1f';
h2.Title="Centrality of the nodes inside the original network";

%Create dendrograms
branches_jaccard = findBranches(A,"jaccard");
rege_similarity=readmatrix("../data/REGE3");
branches_rege = findBranches(A,"rege",rege_similarity);

%Cluster
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

%Plot food webs
network_jaccard=digraph(cluster_A{1,1});
network_rege=digraph(cluster_A{1,2});
network_pattern_modul=digraph(cluster_A{1,3});
network_density_modul=digraph(cluster_A{1,4});
network_groups=digraph(cluster_A{1,5});
plot(network, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_jaccard, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_rege, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_pattern_modul, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_density_modul, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_groups, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');

%Centrality clusters
for i=1:a
    for j=1:c
        centrality_single_clusters{j,i}=centralityClusters(cluster_A{j,i},centralities(j)); %here
        cluster_centrality{j,i}=centralityNodes(centrality_single_clusters{j,i}, cluster_ID(:,i));
    end
end

%Kendall test
for i=1:a
    for j=1:c
        check=[eval(centralities(j)) cluster_centrality{j,i}]; %here
        W(j,i)=KendallCoef(check);
    end
end
rs=((a*W)-1)/(a-1);

%Heatmap
h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";