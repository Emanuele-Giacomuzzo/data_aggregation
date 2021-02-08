clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';
A=readmatrix("../data/adjacency_matrix.txt"); n=length(A); network=digraph(A); network_U=graph(toundirected(A));
node_names = readtable('../data/node_names.txt','Delimiter',' ','ReadVariableNames', false);
centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"kindex";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"]; c=length(centralities);
aggregations=["Jaccard_similarity";"Rege_similarity";"Pattern_modularity";"Density_modularity";"Group_model"]; a=length(aggregations);

%Centrality nodes in original food web
nDC = centrality(network_U,'degree')/(n-1);
nwDC = weightedDegree(A)/(n-1);
nCC = centrality(network_U,'closeness')*(n-1);
nBC = centrality(network,'betweenness')/((n-1)*(n-2)/2);
[s,cs,ns] = statusIndices(A);
[kindex,kbu,ktd,kdir,kindir] = keystoneIndices(A);
TI = topologicalImportance(A,3);
STO = topologicalOverlap(A,3,0.02,0.2,0.02);
TP = trophicPosition(A);
centralities_original=[nDC nwDC nCC nBC s cs ns kindex kbu ktd kdir kindir TI STO TP];

%Cluster creation
branches_jaccard = findBranches(A,"jaccard");
rege_similarity=readmatrix("../variables/REGE3");
branches_rege = findBranches(A,"rege",rege_similarity);
membership_jaccard=cluster(branches_jaccard,'cutoff',0.01);
membership_rege=cluster(branches_rege,'cutoff',0.01);
membership_prey_modularity=patternModularity(A);
membership_density_modularity=densityModularity(A);
membership_groups=readmatrix("../variables/group_model_results.txt");
membership=[membership_jaccard membership_rege membership_prey_modularity membership_density_modularity membership_groups];
clear membership_jaccard membership_rege membership_prey_modularity membership_density_modularity membership_groups;

%Cluster linkage
cluster_size=cell(a,1); possible=cell(a,1); realised=cell(a,1);
for i=1:a 
    cluster_size{i}=clusterSize(membership(:,i));
    possible{i} = possibleConnections(cluster_size{i});
    realised{i} = realisedConnections(A,membership(:,i));
end

weight_method = ["min" "mean" "max" "sum"];
A_clustered=cell(c,a); centrality_clusters=cell(c,a); centrality_nodes=cell(c,a); best_Kendall=zeros(c,a); best_percentage=zeros(c,a); best_weight=strings(c,a); best_weight(:)="binary";
for i=1:a
    for j=1:c
        for k=0.001:50:100
            for l=1:length(weight_method)
                A_clustered_check = buildBinaryNetwork(membership(:,i),possible{i},realised{i},k);
                A_clustered_check = buildWeightedNetwork(A,A_clustered_check,membership(:,i),centralities(j),weight_method(l));
                centrality_clusters_check = centralityClusters(A_clustered_check,centralities(j));
                centrality_nodes_check = centralityNodes(centrality_clusters_check, membership(:,i));
                Kendall_check = ktaub([centralities_original(:,j), centrality_nodes_check],0.05);
                if Kendall_check > best_Kendall(j,i)
                    best_Kendall(j,i) = Kendall_check;
                    best_percentage(j,i) = k;
                    best_weight(j,i) = weight_method(l);
                    A_clustered{j,i} = A_clustered_check;
                    centrality_clusters{j,i}=centrality_clusters_check;
                    centrality_nodes{j,i}=centrality_nodes_check;
                end
                l
            end
            k
        end
        j
    end
    i
end
z=heatmap(aggregations,centralities,best_Kendall);
z.CellLabelFormat = '%.2f';


for i=1:a
nDC = [nDC centrality_nodes{1,i}];
nwDC = [nwDC centrality_nodes{2,i}];
nCC = [nCC centrality_nodes{3,i}];
nBC = [nBC centrality_nodes{4,i}];
s = [s centrality_nodes{5,i}];
cs = [cs centrality_nodes{6,i}];
ns = [ns centrality_nodes{7,i}];
kindex = [kindex centrality_nodes{8,i}];
kbu = [kbu centrality_nodes{9,i}];
ktd = [ktd centrality_nodes{10,i}];
kdir = [kdir centrality_nodes{11,i}];
kindir = [kindir centrality_nodes{12,i}];
TI = [TI centrality_nodes{13,i}];
STO = [STO centrality_nodes{14,i}];
TP = [TP centrality_nodes{15,i}]; %All Nan and INf
end














 














