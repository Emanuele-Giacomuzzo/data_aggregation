function[cluster_identity_rege,adj_rege]=regeClustering(adj_dir_binary,rege_dissimilarity_v)

%Watch out: this toolbox doesn't implement the REGE algorithm. It needs to
%be calcualated from the UCINET VI software (available only for windows at
%https://sites.google.com/site/ucinetsoftware/home). The output of UCINET
%needs then to be transformed into a matlab matrix and saved in the folder
%data. Here I supposed that the maximum of REGE is 1000. 

cd rege_clustering;
n=length(adj_dir_binary);
c=1;
p_value=zeros(10000,1);

rege_average = linkage(rege_v, 'average');

for j=0.01:0.05:1
for i=0.01:0.05:1
    c=c+1;
cluster_identity_rege =cluster(rege_average,'cutoff',i);
cd ..; adj_rege=linkingClusters(adj_dir_binary,cluster_identity_rege,j);
adj_rege_und=toundirected(adj_rege);
network_und_rege=graph(adj_rege_und);
degree_rege=centrality(network_und_rege,'degree')/(n-1);
degree_rege_nodes=centralityspecies(degree_rege, cluster_identity_rege);
degree_compare=[degree, degree_rege_nodes];
p = friedman(degree_compare,1,'off');
p_value(c)=p;
if p_value(c) > p_value(c-1)
    best_threshold=i;
    best_link_percentage=j;
end
end
end

cluster_identity_rege=cluster(rege_average,'cutoff',best_threshold);

cd ..;

adj_rege=linkingClusters(adj_dir_binary,cluster_identity_rege,best_link_percentage);

end