function[centrality_clusters]=calculateCentrality(A_clusters,centrality)

if centrality=="degree" || centrality=="betweenness" || centrality=="closeness" || centrality=="TI" %Undirected binary
    A_clusters_U=toundirected(A_clusters);
    network_U=graph(A_clusters_U);
end

if centrality=="status" || centrality=="keystone" end %Directed binary

if centrality=="degree" centrality_clusters=centrality(network_U,'degree')/(n-1); end
if centrality=="betweenness" centrality_clusters=centrality(network,'betweenness')/[(n-1)*(n-2)/2]; end
if centrality=="closeness" centrality_clusters=centrality(network_U,'closeness')*(n-1); end
if centrality=="TI" [centrality_clusters,~]=topologicalImportance(A_clusters,3); end
if centrality=="TI ratio" [~,centrality_clusters]=topologicalImportance(A_clusters,3); end
if centrality=="status" [centrality_clusters,~,~] = statusIndices(A_clusters); end
if centrality=="controstatus" [~,centrality_clusters,~] = statusIndices(A_clusters); end
if centrality=="net_status" [~,~,centrality_clusters] = statusIndices(A_clusters); end
if centrality=="keystone" [centrality_clusters,~,~,~,~]=keystoneIndices(A_clusters); end
if centrality=="keystone bu" [~,centrality_clusters,~,~,~]=keystoneIndices(A_clusters); end
if centrality=="keystone td" [~,~,centrality_clusters,~,~]=keystoneIndices(A_clusters); end
if centrality=="keystone dir " [~,~,~,centrality_clusters,~]=keystoneIndices(A_clusters); end
if centrality=="keystone indir" [~,~,~,~,centrality_clusters]=keystoneIndices(A_clusters); end
if centrality=="TO" [centrality_clusters,~]=topologicalOverlap(A_clusters,3,0.01); end
if centrality=="TO ratio" [~,centrality_clusters]=topologicalOverlap(A_clusters,3,0.01); end
%if centrality=="STO" end %where's uniqueness?

end