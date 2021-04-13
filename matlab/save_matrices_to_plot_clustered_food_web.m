%Adjacency matrix
file = "/Users/ema/github/data_aggregation/r/plotting/A_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
writematrix(A_clusters,file);

%Coordinates of the clustered food web
file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
writematrix(coordinates_clusters,file);    

%Colors of the original food web 
file = "/Users/ema/github/data_aggregation/r/plotting/colors_original_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
writematrix(node_colors,file);

%Colors of the clustered food webs 
file = "/Users/ema/github/data_aggregation/r/plotting/colors_clustered_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
writematrix(cluster_colors,file);

%Sizes of the clusters
file = "/Users/ema/github/data_aggregation/r/plotting/cluster_sizes_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
writematrix(size_of_clusters,file);