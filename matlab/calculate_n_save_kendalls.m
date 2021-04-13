for clustering = 1:length(clustering_methods)
    for centr = 1:length(centralities)
        column = 0;
        for linkage = 1:length(linkage_methods)
            for strength = 1:length(strength_methods)
                column = column + 1;
                A_aggregated_weighted = buildWeightedNetwork(A, membership{web,clustering}, strength_methods(strength));
                A_aggregated_binary = buildBinaryNetwork(realised_link_ratio{clustering}, linkage_methods(linkage));
                A_aggregated{web}{clustering,column} = A_aggregated_weighted .* A_aggregated_binary;
                centrality_clusters = calculateClusterCentrality(A_aggregated{web}{clustering,column}, centralities(centr));
                centrality_nodes = assignNodeCentrality(centrality_clusters, membership{web,clustering});
                Kendalls{web}{clustering}(centr, column) = calculateKendall([centralities_original(:,centr) centrality_nodes']);
            end
        end
    end
    path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
    writematrix(Kendalls{web}{clustering}, path);
end