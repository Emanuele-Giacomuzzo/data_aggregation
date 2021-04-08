cd '/Users/ema/github/data_aggregation/matlab'

%Vector with mportant and not important species
WDC_before = calculateWDC(A_ecobase{chosen_web});
importance_before = repmat("not important", length(WDC_before), 1);
[~,keystone] = max(WDC_before);
importance_before(keystone) = "important";

%Coordinates before aggregation
coordinates_before = zeros(length(A_ecobase{chosen_web}),2);
for node = 1:length(coordinates_before)
    coordinates_before(node,1) = normrnd(0.5,0.25);
    coordinates_before(node,2) = TP(node);
end
file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_original_web_" + web + ".csv";
writematrix(coordinates_before, file);

for clustering = 1:4%length(clustering_methods)
    
    %Best linkage and strength method
    [~,best_strength_n_links] = max(kendalls{chosen_web,clustering}(chosen_importance,:));
    if clustering == 3
        best_strength_n_links = 2; 
    end
    
    %Adjacency matrix
    A_clusters = A_aggregated{chosen_web}{clustering,best_strength_n_links};
    
    %Vector with mportant and not important species
    WDC_after_clusters = calculateWDC(A_clusters);
    importance_after_clusters = repmat("not important", length(A_clusters),1);
    [~,keystone] = max(WDC_after_clusters);
    importance_after_clusters(keystone) = "important";
    importance_after_nodes = (assignNodeCentrality(importance_after_clusters, membership{chosen_web,clustering}))';
    
    node_colors = assignNodeColors(importance_before, importance_after_nodes);
    cluster_colors = assignClusterColors(membership{chosen_web,clustering});
    size_of_clusters = findClusterSize(membership{chosen_web,clustering});
    
    TP_clusters = calculateTP(A_clusters);
    nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
    if nan_inf ~= 0
        A_clusters_DAG = createDAG(A_clusters);
        TP_clusters = calculateTP(A_clusters_DAG);
        nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
        if nan_inf ~= 0
            "Problem with TP"
        end
    end
    
    coordinates_clusters = double.empty;
    nodes_of_clusters = cell(length(A_clusters),2);
    for cluster = 1:length(A_clusters)
        nodes_of_clusters{cluster,1} = find(membership{chosen_web,clustering}==cluster);
        for node = 1:length(nodes_of_clusters{cluster})
            nodes_of_clusters{cluster,2} = [nodes_of_clusters{cluster,2}; coordinates_before(nodes_of_clusters{cluster,1}(node),1)];
        end
        nodes_of_clusters{cluster,2} = mean(nodes_of_clusters{cluster,2});
        coordinates_clusters(cluster) = nodes_of_clusters{cluster,2};
    end
    coordinates_clusters = [coordinates_clusters' TP_clusters];
    
    file = "/Users/ema/github/data_aggregation/r/plotting/A_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(A_clusters,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(coordinates_clusters,file);    
    file = "/Users/ema/github/data_aggregation/r/plotting/colors_original_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(node_colors,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/colors_clustered_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(cluster_colors,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/cluster_sizes_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(size_of_clusters,file);
    
end