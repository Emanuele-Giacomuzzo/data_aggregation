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