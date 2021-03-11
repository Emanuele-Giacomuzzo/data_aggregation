function[centrality_clusters]=centralityClusters(A_clustered,centrality_type)

network=digraph(A_clustered);
A_clustered_U=toundirected(A_clustered);
network_U=graph(A_clustered_U);
n=length(A_clustered);
TP = trophicPosition(A_clustered);

if centrality_type=="nDC", centrality_clusters = centrality(network_U,'degree')/(n-1); end
if centrality_type=="nwDC", centrality_clusters = weightedDegree(A_clustered)/(n-1); end
if centrality_type=="nBC", centrality_clusters = centrality(network,'betweenness')/[(n-1)*(n-2)/2]; end
if centrality_type=="nCC", centrality_clusters = centrality(network_U,'closeness')*(n-1); end
if centrality_type=="s", A_clustered = createDAG(A_clustered,TP); [centrality_clusters,~,~] = statusIndices(A_clustered); end
if centrality_type=="cs", A_clustered = createDAG(A_clustered,TP); [~,centrality_clusters,~] = statusIndices(A_clustered); end
if centrality_type=="ns", A_clustered = createDAG(A_clustered,TP); [~,~,centrality_clusters] = statusIndices(A_clustered); end
if centrality_type=="kindex", A_clustered = createDAG(A_clustered,TP); [centrality_clusters,~,~,~,~] = keystoneIndices(A_clustered); end
if centrality_type=="kbu", A_clustered = createDAG(A_clustered,TP); [~,centrality_clusters,~,~,~] = keystoneIndices(A_clustered); end
if centrality_type=="ktd", A_clustered = createDAG(A_clustered,TP); [~,~,centrality_clusters,~,~] = keystoneIndices(A_clustered); end
if centrality_type=="kdir", A_clustered = createDAG(A_clustered,TP); [~,~,~,centrality_clusters,~] = keystoneIndices(A_clustered); end
if centrality_type=="kindir", A_clustered = createDAG(A_clustered,TP); [~,~,~,~,centrality_clusters] = keystoneIndices(A_clustered); end
if centrality_type=="TI1", centrality_clusters = topologicalImportance(A_clustered,1,"false"); end
if centrality_type=="TI3", centrality_clusters = topologicalImportance(A_clustered,3,"false"); end
if centrality_type=="TI5", centrality_clusters = topologicalImportance(A_clustered,5,"false"); end
if centrality_type=="WI1", centrality_clusters = topologicalImportance(A_clustered,1,"true"); end
if centrality_type=="WI3", centrality_clusters = topologicalImportance(A_clustered,3,"true"); end
if centrality_type=="WI5", centrality_clusters = topologicalImportance(A_clustered,5,"true"); end
if centrality_type=="STO1", centrality_clusters = topologicalOverlap(A_clustered,1,0.01,0.1,0.01,"binary"); end
if centrality_type=="STO3", centrality_clusters = topologicalOverlap(A_clustered,3,0.01,0.1,0.01,"binary"); end
if centrality_type=="STO5", centrality_clusters = topologicalOverlap(A_clustered,5,0.01,0.1,0.01,"binary"); end
if centrality_type=="wSTO1", centrality_clusters = topologicalOverlap(A_clustered,1,0.01,0.1,0.01,"weighted"); end
if centrality_type=="wSTO3", centrality_clusters = topologicalOverlap(A_clustered,3,0.01,0.1,0.01,"weighted"); end
if centrality_type=="wSTO5", centrality_clusters = topologicalOverlap(A_clustered,5,0.01,0.1,0.01,"weighted"); end
if centrality_type=="TP", centrality_clusters = trophicPosition(A_clustered); end

end