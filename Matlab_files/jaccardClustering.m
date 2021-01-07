function[cluster_identity_jac]=jaccardClustering(adj_dir_binary)

c=1;
p_value=zeros(10000,1);

jaccard_v = pdist (adj_dir_binary, 'jaccard');
jaccard_average = linkage(jaccard_v, 'average');

for j=0.01:0.01:1
for i=0.01:0.01:1
    c=c+1;
cluster_identity_jac=jaccardClustering(adj_dir_binary,i);
adj_jaccard=linkingClusters(adj_dir_binary,cluster_identity_jac,j);
adj_jaccard_und=toundirected(adj_jaccard);
network_und_jac=graph(adj_jaccard_und);
degree_jac=centrality(network_und_jac,'degree')/(n-1);
degree_jac_nodes=centralityspecies(degree_jac, cluster_identity_jac);
degree_compare=[degree, degree_jac_nodes];
p = friedman(degree_compare,1);
p_value(c)=p;
if p_value(c) > p_value(c-1)
    best_threshold=i;
    best_link_percentage=j;
end
end
end

end