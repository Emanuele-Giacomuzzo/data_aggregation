clc,clear,cd '/Users/ema/Google Drive/Github/MATLAB/Data_aggregation/Matlab_files';
load adj_dir_weight; % i (prey) -> j (predator)
load node_names;

adj_dir_binary=tounweighted(adj_dir_weight);
adj_undir_weight=toundirected(adj_dir_weight);
adj_undir_binary=toundirected(adj_dir_binary);

network_dir=digraph(adj_dir_weight);
network_und=graph(adj_undir_weight);
n=length(adj_dir_weight);

%REGE clustering
threshold=0.5;
link_percentage=0.25;
load REGE3.mat;
REGE3_norm=REGE3/1000;
REGE3_dis=similarityToDissimilarity(REGE3_norm);

rege_v=squareform(REGE3_dis);
rege_average = linkage(rege_v, 'average');
cluster_identity_rege =cluster(rege_average,'cutoff',threshold);
cluster_size_rege=clustersize(cluster_identity_rege);
possible_connections=possibleconnections(cluster_size_rege);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity_rege);

adj_cluster_rege=clusterslinkage(adj_dir_binary,cluster_identity_rege,realised_connections,possible_connections,link_percentage);
adj_cluster_rege_undir=toundirected(adj_cluster_rege); %Here's the problem
network_rege=graph(adj_cluster_rege_undir);

%Degree centrality (UB)
degree_rege_clusters=centrality(network_rege,'betweenness');
degree_rege=centralityspecies(degree_rege_clusters,cluster_identity_rege)/(n-1);

%Weighted degree centrality (UW)
weighted_degree_rege_clusters=weightedDegree(adj_cluster_rege_undir)/(n-1);
weighted_degree_rege=centralityspecies(weighted_degree_rege_clusters, cluster_identity_rege);

%Closeness centrality (UB)
closeness_rege_clusters=centrality(network_rege,'closeness');
closeness_rege=centralityspecies(closeness_rege_clusters, cluster_identity_rege);

%Betweenness centrality (UB)
betweenness_rege_clusters=centrality(network_rege,'betweenness');
betweenness_rege=centralityspecies(betweenness_rege_clusters,cluster_identity_rege)/[(n-1)*(n-2)/2];

%Topological overlap (UB)
nr_of_steps=4;
threshold=0.01;
degree_m_rege=degreematrix(adj_undir_binary, network_und);
n_step_rege=onestepeffect(adj_dir_weight, degree_m_rege); %It's the same as for topological importance
n_step_rege=stepeffectoverlap(adj_dir_weight,n_step_rege, nr_of_steps);
average_effect_rege=averageeffect(adj_dir_weight,n_step_rege, nr_of_steps);
interactor_rege=interactormatrix(average_effect_rege, threshold);
node_overlap_m_rege=topologicaloverlapmatrix(interactor_rege);

overlap_rege=sum(node_overlap_m_rege,2);
overlap_ratio_rege=overlap_rege/sum(overlap_rege);

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
