function[centrality_clusters] = centralityClusters(A_clustered, centrality_type)

network = digraph(A_clustered);
A_clustered_U = toundirected(A_clustered);
network_U = graph(A_clustered_U);
n = length(A_clustered);
TP = calculateTP(A_clustered);

if centrality_type=="DC", centrality_clusters = centrality(network_U,'degree'); end
if centrality_type=="WDC", centrality_clusters = calculateWDC(A_clustered); end
if centrality_type=="BC", centrality_clusters = centrality(network,'betweenness'); end
if centrality_type=="CC", centrality_clusters = centrality(network_U,'closeness'); end
if centrality_type=="s", A_clustered = createDAG(A_clustered,TP); [centrality_clusters,~,~] = calculateStatus(A_clustered); end
if centrality_type=="cs", A_clustered = createDAG(A_clustered,TP); [~,centrality_clusters,~] = calculateStatus(A_clustered); end
if centrality_type=="ns", A_clustered = createDAG(A_clustered,TP); [~,~,centrality_clusters] = calculateStatus(A_clustered); end
if centrality_type=="kindex", A_clustered = createDAG(A_clustered,TP); [centrality_clusters,~,~,~,~] = calculateKeystone(A_clustered); end
if centrality_type=="kbu", A_clustered = createDAG(A_clustered,TP); [~,centrality_clusters,~,~,~] = calculateKeystone(A_clustered); end
if centrality_type=="ktd", A_clustered = createDAG(A_clustered,TP); [~,~,centrality_clusters,~,~] = calculateKeystone(A_clustered); end
if centrality_type=="kdir", A_clustered = createDAG(A_clustered,TP); [~,~,~,centrality_clusters,~] = calculateKeystone(A_clustered); end
if centrality_type=="kindir", A_clustered = createDAG(A_clustered,TP); [~,~,~,~,centrality_clusters] = calculateKeystone(A_clustered); end
if centrality_type=="TI1", centrality_clusters = calculateTI(A_clustered,1,"false"); end
if centrality_type=="TI3", centrality_clusters = calculateTI(A_clustered,3,"false"); end
if centrality_type=="TI5", centrality_clusters = calculateTI(A_clustered,5,"false"); end
if centrality_type=="WI1", centrality_clusters = calculateTI(A_clustered,1,"true"); end
if centrality_type=="WI3", centrality_clusters = calculateTI(A_clustered,3,"true"); end
if centrality_type=="WI5", centrality_clusters = calculateTI(A_clustered,5,"true"); end
if centrality_type=="STO1", centrality_clusters = calculateSTO(A_clustered,1,0.01,0.1,0.01,"binary"); end
if centrality_type=="STO3", centrality_clusters = calculateSTO(A_clustered,3,0.01,0.1,0.01,"binary"); end
if centrality_type=="STO5", centrality_clusters = calculateSTO(A_clustered,5,0.01,0.1,0.01,"binary"); end
if centrality_type=="wSTO1", centrality_clusters = calculateSTO(A_clustered,1,0.01,0.1,0.01,"weighted"); end
if centrality_type=="wSTO3", centrality_clusters = calculateSTO(A_clustered,3,0.01,0.1,0.01,"weighted"); end
if centrality_type=="wSTO5", centrality_clusters = calculateSTO(A_clustered,5,0.01,0.1,0.01,"weighted"); end
if centrality_type=="TP", centrality_clusters = calculateTP(A_clustered); end

end