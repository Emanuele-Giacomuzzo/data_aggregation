clc,clear;
cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load adj_dir_weight;
load adj_dir_binary;
load adj_undir_weight;
load adj_undir_binary;
load node_names;

food_web=digraph(adj_dir_weight); 
food_web_undir=graph(adj_undir_weight);
plot(food_web,'NodeLabel',node_names);

centrality_degree=centrality(food_web_undir,'degree');
centrality_close=centrality(food_web_undir,'closeness');
centrality_between=centrality(food_web,'betweenness');
centrality_overlap=topological_overlap(adj_dir_weight, 0.1);
centrality_uniqueness=species_uniqueness(adj_dir_weight, 0.1, 1.0, 0.1);
%centrality_importance=topological_importance(adj_undir_binary);
centrality_status = status_index(food_web);
centrality_controstatus = controstatus_index(food_web);
centrality_net_status = centrality_status - centrality_controstatus;
%centrality_keystone=keystone_index(adj_dir_weight);
%centrality_keystoneness=keystoneness(adj,weghted);

jaccard_vector = pdist (adj_dir_binary, 'jaccard'); jaccard_matrix = squareform (jaccard_vector);
jaccard_single = linkage(jaccard_vector, 'single');
jaccard_complete = linkage(jaccard_vector, 'complete');
jaccard_average = linkage(jaccard_vector, 'average');
jaccard_weighted = linkage(jaccard_vector, 'weighted');
jaccard_centroid = linkage(jaccard_vector, 'centroid');
jaccard_median = linkage(jaccard_vector, 'median');
jaccard_ward = linkage(jaccard_vector, 'ward');
dendrogram(jaccard_single, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_complete, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_average, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_weighted, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_centroid, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_median, 63,'Orientation','left','Labels',node_names);
dendrogram(jaccard_ward, 63,'Orientation','left','Labels',node_names);
cophenet_jac_single = cophenet(jaccard_single, jaccard_vector);
cophenet_jac_complete = cophenet(jaccard_complete, jaccard_vector);
cophenet_jac_average = cophenet(jaccard_average, jaccard_vector);
cophenet_jac_weighted = cophenet(jaccard_weighted, jaccard_vector);
cophenet_jac_centroid = cophenet(jaccard_centroid, jaccard_vector);
cophenet_jac_median = cophenet(jaccard_median, jaccard_vector);
cophenet_jac_ward = cophenet(jaccard_ward, jaccard_vector);
inconsistent_jac_single=inconsistent(jaccard_single);
inconsistent_jac_complete=inconsistent(jaccard_complete);
inconsistent_jac_average=inconsistent(jaccard_average);
inconsistent_jac_weighted=inconsistent(jaccard_weighted);
inconsistent_jac_centroid=inconsistent(jaccard_centroid);
inconsistent_jac_median=inconsistent(jaccard_median);
inconsistent_jac_ward=inconsistent(jaccard_ward);

%stochastic block modelling

%directed modularity
