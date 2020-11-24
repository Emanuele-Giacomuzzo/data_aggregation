clc,clear;
cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load weighted_network.mat weighted_network;
load binary_network.mat binary_network;
load node_names.mat node_names;
graph=digraph(weighted_network);
node_names_table = table(node_names); graph.Nodes = node_names_table; 
plot(graph,'NodeLabel',node_names);

degree_m=degree(graph);
diagonal=diag(weighted_network);

undir_network=weighted_network+transpose(weighted_network);
undir_network_noloop=undir_network-diag(diag(undir_network));
binary_undir_network=tounweighted(undir_network_noloop);
undir_graph=graph(binary_undir_network);

undirected_graph=graph(undir_network);
undirected_graph.Nodes = node_names_table;
plot(undirected_graph,'NodeLabel', node_names);

jaccard_vector = pdist (binary_network, 'jaccard'); jaccard_matrix = squareform (jaccard_vector);
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

cluster_jac_single=cluster(jaccard_single,'cutoff',0.1);