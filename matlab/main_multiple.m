%Reading only one matrix
clc,clear; cd '/Users/ema/github/data_aggregation/matlab'; warning('off','all');
load('../data/ecobase/A_ecobase.mat');

for web=1:length(A_loops)
if length(A_loops(web)) > 1
A = A_loops{web}; n=length(A); network=digraph(A); network_U=graph(toundirected(A));
A_loopless = A;

centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"kindex";"kbu";"ktd";"kdir";"kindir";"TI1";"TI3";"TI5";"WI1";"WI3";"WI5";"STO";"TP"]; c=length(centralities);
nDC = centrality(network_U,'degree')/(n-1);
nwDC = weightedDegree(A)/(n-1);
nCC = centrality(network_U,'closeness')*(n-1);
nBC = centrality(network,'betweenness')/((n-1)*(n-2)/2);
[s,cs,ns] = statusIndices(A_loopless);
[kindex,kbu,ktd,kdir,kindir] = keystoneIndices(A_loopless);
TI1 = topologicalImportance(A,1,"false");
TI3 = topologicalImportance(A,3,"false");
TI5 = topologicalImportance(A,5,"false");
WI1 = topologicalImportance(A,1,"true");
WI3 = topologicalImportance(A,3,"true");
WI5 = topologicalImportance(A,5,"true");
STO = topologicalOverlap(A,3,0.02,0.2,0.02);
TP = trophicPosition(A);
centralities_original=[nDC nwDC nCC nBC s cs ns kindex kbu ktd kdir kindir TI1 TI3 TI5 WI1 WI3 WI5 STO TP];

aggregations=["Jaccard_similarity";"Rege_similarity";"Prey_modularity";"Density_modularity";"Group_model"]; a=length(aggregations);
branches_jaccard = findBranches(A,"jaccard");
rege_similarity=readmatrix("../variables/REGE3");
branches_rege = findBranches(A,"rege",rege_similarity);
membership_jaccard=cluster(branches_jaccard,'cutoff',0.01);
membership_rege=cluster(branches_rege,'cutoff',0.01);
membership_density_modularity = readmatrix("../variables/density_based_results.txt");
membership_prey_modularity = readmatrix("../variables/prey_based_results.txt");
membership_groups=readmatrix("../variables/group_model_results.txt");
membership=[membership_jaccard membership_rege membership_prey_modularity membership_density_modularity membership_groups];
clear membership_jaccard membership_rege membership_prey_modularity membership_density_modularity membership_groups;

cluster_size=cell(a,1); possible=cell(a,1); realised=cell(a,1); realised_ratio=cell(a,1);
for i=1:a 
    cluster_size{i}=clusterSize(membership(:,i));
    possible{i} = possibleConnections(cluster_size{i});
    realised{i} = realisedConnections(A,membership(:,i));
    realised_ratio{i}=realisedConnectionsRatio(possible{i},realised{i});
end

percentages=[0.001 0.05:0.05:1]; p=length(percentages);
weight_method = ["min" "mean" "max" "sum"]; w=length(weight_method);
best_Kendall=inf(c,a)*-1; best_percentage=zeros(c,a); best_weight=strings(c,a); %best_weight(:)="binary";
A_clustered=cell(c,a); centrality_clusters=cell(c,a);  centrality_nodes=cell(c,a);
parfor i=1:a
    for j=1:c
        for k=1:p
            for l=1:w
                A_clustered_check = buildBinaryNetwork(realised_ratio{i}, percentages(k));
                if centralities(j)=="nwDC" || centralities(j)=="STO" || centralities(j)=="WI1" || centralities(j)=="WI3" || centralities(j)=="WI5"
                    A_clustered_check = buildWeightedNetwork(A,A_clustered_check,membership(:,i),weight_method(l));
                end
                centrality_clusters_check = centralityClusters(A_clustered_check,centralities(j));
                centrality_nodes_check = centralityNodes(centrality_clusters_check, membership(:,i));
                if max(isnan(centrality_nodes_check))~=1 && max(isinf(centrality_nodes_check))~=1
                    Kendall_check = ktaub([centralities_original(:,j), centrality_nodes_check],0.05);
                end
                if Kendall_check > best_Kendall(j,i)
                    best_Kendall(j,i) = Kendall_check;
                    best_percentage(j,i) = percentages(k);
                    best_weight(j,i) = weight_method(l);
                    A_clustered{j,i} = A_clustered_check;
                    centrality_clusters{j,i}=centrality_clusters_check;
                    centrality_nodes{j,i}=centrality_nodes_check;
                end
            end
        end
    end
end

name = "best_kendall_" + web + ".txt";
writematrix(best_Kendall,name);
name = "best_percentage_" + web + ".txt";
writematrix(best_percentage,name);
name = "best_weight_" + web + ".txt";
writematrix(best_weight,name);

end
end