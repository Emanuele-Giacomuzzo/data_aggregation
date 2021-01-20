adj_cluster_jaccard_undir=toundirected(adj_cluster_jaccard);
network_jac=graph(adj_cluster_jaccard_undir);


%Degree centrality (UB)
degree_jac_clusters=centrality(network_jac,'betweenness');
degree_jac=centralityspecies(degree_jac_clusters,cluster_identity_jac)/(n-1);

%Weighted degree centrality (UW)
weighted_degree_jac_clusters=weightedDegree(adj_cluster_jaccard_undir)/(n-1);
weighted_degree_jac=centralityspecies(weighted_degree_jac_clusters, cluster_identity_jac);

%Closeness centrality (UB)
closeness_jac_clusters=centrality(network_jac,'closeness');
closeness_jac=centralityspecies(closeness_jac_clusters, cluster_identity_jac);

%Betweenness centrality (UB)
betweenness_jac_clusters=centrality(network_jac,'betweenness');
betweenness_jac=centralityspecies(betweenness_jac_clusters,cluster_identity_jac)/[(n-1)*(n-2)/2];

%Topological overlap (UB)
nr_of_steps=4;
threshold=0.01;
degree_m_jac=degreematrix(adj_undir_binary, network_und);
n_step_jac=onestepeffect(adj_dir_weight, degree_m_jac); %It's the same as for topological importance
n_step_jac=stepeffectoverlap(adj_dir_weight,n_step_jac, nr_of_steps);
average_effect_jac=averageeffect(adj_dir_weight,n_step_jac, nr_of_steps);
interactor_jac=interactormatrix(average_effect_jac, threshold);
node_overlap_m_jac=topologicaloverlapmatrix(interactor_jac);
overlap_jac=sum(node_overlap_m_jac,2);
overlap_ratio_jac=overlap_jac/sum(overlap_jac);

%Weighted topological overlap (UW)
nr_of_steps=4;
threshold=0.01;
weighted_one_step=weightedOneStep(adj_dir_weight);

%Status index (UB)
path_length=distances(network_dir,'Method','unweighted');
path_length=getridofinf(path_length);
status=sum(path_length,2);
network_flipped=flipedge(network_dir);
path_length_inv=distances(network_flipped,'Method','unweighted');
path_length_inv=getridofinf(path_length_inv);
controstatus=sum(path_length_inv,2);
net_status = status - controstatus;
end