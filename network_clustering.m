clc,clear,cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load adj_dir_weight; % i -> j
load adj_dir_binary;
load adj_undir_weight;
load adj_undir_binary;
load node_names;

food_web=digraph(adj_dir_weight); 
food_web_undir=graph(adj_undir_weight);

centrality_degree=centrality(food_web_undir,'degree');
centrality_close=centrality(food_web_undir,'closeness');
centrality_between=centrality(food_web,'betweenness');
centrality_overlap=topological_overlap(adj_dir_weight, 0.1);
centrality_uniqueness=species_uniqueness(adj_dir_weight, 0.1, 1.0, 0.1);
centrality_importance=topological_importance(adj_undir_binary, food_web_undir, 3);
centrality_status = status_index(food_web);
centrality_controstatus = controstatus_index(food_web);
centrality_net_status = centrality_status - centrality_controstatus;

jaccard_vector = pdist (adj_dir_binary, 'jaccard'); jaccard_matrix = squareform (jaccard_vector);
jaccard_average = linkage(jaccard_vector, 'average');
cophenet_jac_average = cophenet(jaccard_average, jaccard_vector);
inconsistent_jac_average=inconsistent(jaccard_average);
cluster_identity =cluster(jaccard_average,'cutoff',0.5);
adj_clustered=clusterslinkage(adj_dir_binary,cluster_identity,0.25);

x=input('Enter a value for x: ');

plot(food_web,'NodeLabel',node_names);
dendrogram(jaccard_average, 63,'Orientation','left','Labels',node_names);