clc,clear;
cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load weighted_network.mat weighted_network;
load unweighted_network.mat unweighted_network;
load node_names.mat node_names; 
graph=digraph(weighted_network);
node_names_table = table(node_names); graph.Nodes = node_names_table; 
plot(graph,'NodeLabel',node_names);

jaccard_vector = pdist (unweighted_network, 'jaccard'); jaccard_matrix = squareform (jaccard_vector);
jaccard_single = linkage(jaccard_vector, 'single');
dendrogram(jaccard_single)