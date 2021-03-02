A_clustered2=cell(a,1); centrality_clusters=cell(a,1);  centrality_nodes=cell(a,1); Kendall=zeros(c,a);
for i=1:a
    A_clustered2{i} = buildBinaryNetwork(realised_ratio{i}, 0.5);
    A_clustered2{i} = buildWeightedNetwork(A,A_clustered_check,membership(:,i),"min");
    for j=1:c
        centrality_clusters{j,i} = centralityClusters(A_clustered2{i},centralities(j));
        centrality_nodes{j,i} = centralityNodes(centrality_clusters{j,i}, membership(:,i));
        if max(isnan(centrality_nodes_check))~=1 && max(isinf(centrality_nodes_check))~=1
            Kendall(j,i) = ktaub([centralities_original(:,j), centrality_nodes_check],0.05);
        end
    end
end