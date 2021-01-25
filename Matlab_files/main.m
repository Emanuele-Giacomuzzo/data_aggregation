clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files';
A=readmatrix("../data/adjacency_matrix.txt"); n=length(A); network=digraph(A); network_U=graph(toundirected(A));
node_names = readtable('../data/node_names.txt','Delimiter',' ');
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
A_clustered=cell(c,a); centrality_clusters=cell(c,a); centrality_nodes=cell(c,a); best_ratio=double.empty; best_weight=string.empty; best_W=double.empty; W_check=0; W=zeros(c,a); rs=double.empty;
for i=1:a
    cluster_size = clusterSize(membership(:,i));
    possible_connections = possibleConnections(cluster_size);
    realised_connections = realisedConnections(A,membership(:,i));
    for j=1:c
        centrality_type=centralities(j);
        best_ratio(j,i)=0;
        best_weight(j,i)="binary";
        best_W(j,i)=0;
        for k=1:1:100
            ratio = k;
            for l=1:length(weight_type)
                weight = weight_type(l);
                A_clustered_check = buildBinaryNetwork(membership(:,i),possible_connections,realised_connections,ratio); 
                A_clustered_check = buildWeightedNetwork(A,A_clustered_check,membership(:,i),centrality_type,weight);
                centrality_clusters=centralityClusters(A_clustered_check,centrality_type); 
                centrality_nodes=centralityNodes(centrality_clusters, membership(:,i));
                centrality_compare=[eval(centrality_type), centrality_nodes];
                W_check = KendallCoef(centrality_compare);
                if W_check > best_W 
                    best_W=W_check;
                    best_ratio=ratio;
                    best_weight=weight;
                end
            end
        end
        W(j,i)=best_W;
        rs(j,i)=((a*W(j,i))-1)/(a-1);
        A_clustered{j,i} = buildBinaryNetwork(membership(:,i),possible_connections,realised_connections,best_ratio);
        A_clustered{j,i} = buildWeightedNetwork(A,A_clustered{j,i},membership(:,i),centrality_type,best_weight);
        centrality_clusters{j,i}=centralityClusters(A_clustered{j,i},centralities(j));
        centrality_nodes{j,i}=centralityNodes(centrality_clusters{j,i}, membership(:,i));
    end
end




































