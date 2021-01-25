clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';
A=readmatrix("../data/adjacency_matrix.txt"); n=length(A); network=digraph(A); network_U=graph(toundirected(A));
node_names = readtable('../data/node_names.txt','Delimiter',' ');
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
weight_type = ["min" "mean" "max" "sum"];
A_clustered=cell(c,a); centrality_clusters=cell(c,a); centrality_nodes=cell(c,a); best_percentage=double.empty; best_weight=string.empty; best_W=double.empty; W_check=0; W=zeros(c,a); rs=double.empty;
for i=1:a
    cluster_size = clusterSize(membership(:,i));
    possible_connections = possibleConnections(cluster_size);
    realised_connections = realisedConnections(A,membership(:,i));
    for j=1:c
        centrality_type=centralities(j);
        best_percentage(j,i)=0;
        best_weight(j,i)="binary";
        best_W=0;
        for k=1:1:100
            percentage = k;
            for l=1:length(weight_type)
                weight = weight_type(l);
                A_clustered_check = buildBinaryNetwork(membership(:,i),possible_connections,realised_connections,percentage); 
                A_clustered_check = buildWeightedNetwork(A,A_clustered_check,membership(:,i),centrality_type,weight);
                centrality_clusters_check = centralityClusters(A_clustered_check,centrality_type);
                centrality_nodes_check = centralityNodes(centrality_clusters_check, membership(:,i));
                centrality_compare = [eval(centrality_type), centrality_nodes_check];
                W_check = KendallCoef(centrality_compare);
                if W_check > best_W 
                    best_W = W_check;
                    best_percentage = percentage;
                    best_weight = weight;
                end
            end
        end
        W(j,i)=W(j,i)+best_W;  
        A_clustered{j,i} = buildBinaryNetwork(membership(:,i),possible_connections,realised_connections,best_percentage);
        A_clustered{j,i} = buildWeightedNetwork(A,A_clustered{j,i},membership(:,i),centrality_type,best_weight);
        centrality_clusters{j,i}=centralityClusters(A_clustered{j,i},centralities(j)); 
        centrality_nodes{j,i}=centralityNodes(centrality_clusters{j,i}, membership(:,i));
    end
end
rs=((a*W)-1)/(a-1);

for i=1:a
nDC = [nDC centrality_nodes{1,a}];
nwDC = [nwDC centrality_nodes{2,a}];
nCC = [nCC centrality_nodes{3,a}];
nBC = [nBC centrality_nodes{4,a}];
s = [s centrality_nodes{5,a}];
cs = [cs centrality_nodes{6,a}];
ns = [ns centrality_nodes{7,a}];
kindex = [kindex centrality_nodes{8,a}];
kbu = [kbu centrality_nodes{9,a}];
ktd = [ktd centrality_nodes{10,a}];
kdir = [kdir centrality_nodes{11,a}];
kindir = [kindir centrality_nodes{12,a}];
TI = [TI centrality_nodes{13,a}];
STO = [STO centrality_nodes{14,a}];
TP = [TP centrality_nodes{15,a}]; %All Nan and INf
end
































