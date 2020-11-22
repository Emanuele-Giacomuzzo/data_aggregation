clc,clear;
cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load network.mat network;
load node_names.mat node_names; node_names_table = table(node_names);
graph=digraph(network); graph.Nodes = node_names_table;
%plot(graph,'NodeLabel',node_names)

jaccard = pdist (network, 'jaccard'); jaccard_matrix = squareform (jaccard);
jaccard_single = linkage(jaccard, 'single');
dendrogram(jaccard_single)