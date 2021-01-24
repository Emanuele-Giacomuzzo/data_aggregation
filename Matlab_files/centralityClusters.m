function[centrality_clusters]=centralityClusters(A_clusters,centrality_type)

network=digraph(A_clusters);
A_clusters_U=toundirected(A_clusters);
network_U=graph(A_clusters_U);
n=length(A_clusters);

if centrality_type=="nDC", centrality_clusters=centrality(network_U,'degree')/(n-1); end
if centrality_type=="nwDC", centrality_clusters=weightedDegree(A_clusters)/(n-1); end
if centrality_type=="nBC", centrality_clusters=centrality(network,'betweenness')/[(n-1)*(n-2)/2]; end
if centrality_type=="nCC", centrality_clusters=centrality(network_U,'closeness')*(n-1); end
if centrality_type=="s", [centrality_clusters,~,~] = statusIndices(A_clusters); end
if centrality_type=="cs", [~,centrality_clusters,~] = statusIndices(A_clusters); end
if centrality_type=="ns", [~,~,centrality_clusters] = statusIndices(A_clusters); end
if centrality_type=="k", [centrality_clusters,~,~,~,~]=keystoneIndices(A_clusters); end
if centrality_type=="kbu", [~,centrality_clusters,~,~,~]=keystoneIndices(A_clusters); end
if centrality_type=="ktd", [~,~,centrality_clusters,~,~]=keystoneIndices(A_clusters); end
if centrality_type=="kdir", [~,~,~,centrality_clusters,~]=keystoneIndices(A_clusters); end
if centrality_type=="kindir", [~,~,~,~,centrality_clusters]=keystoneIndices(A_clusters); end
if centrality_type=="TI", [centrality_clusters,~]=topologicalImportance(A_clusters,3); end
if centrality_type=="STO", [centrality_clusters,~]=topologicalOverlap(A_clusters,3,0.01,0.2,0.01); end
if centrality_type=="TP", centrality_clusters=trophicPosition(A_clusters); end

end