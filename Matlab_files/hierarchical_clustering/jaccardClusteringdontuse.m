function[cluster_identity_jac,adj_jaccard]=jaccardClustering(adj_dir_binary,degree,best_linkage,jaccard_v,jaccard_linked)

n=length(adj_dir_binary);
c=1;
p_value=zeros(10000,1);

for j=0.01:0.05:1
for i=0.01:0.05:1
    c=c+1;
cluster_identity_jac =cluster(jaccard_linked,'cutoff',i);
adj_jaccard=linkingClusters(adj_dir_binary,cluster_identity_jac,j);
adj_jaccard_und=toundirected(adj_jaccard);
network_und_jac=graph(adj_jaccard_und);
degree_jac=centrality(network_und_jac,'degree')/(n-1);
degree_jac_nodes=centralityspecies(degree_jac, cluster_identity_jac);
degree_compare=[degree, degree_jac_nodes];
p = friedman(degree_compare,1,'off');
p_value(c)=p;
if p_value(c) > p_value(c-1)
    best_threshold=i;
    best_link_percentage=j;
end
end
end

cluster_identity_jac=cluster(jaccard_linked,'cutoff',best_threshold);
adj_jaccard=linkingClusters(adj_dir_binary,cluster_identity_jac,best_link_percentage);

end