%% FIND CLUSTER SIZES
for web = 1:tot_web_nr
    for clustering = 1:length(clustering_methods)
        cluster_sizes(web,clustering) = max(membership{web,clustering}) / length(A_ecobase{web});
    end
end
[row,col] = find(cluster_sizes == 1);
cluster_sizes = rmmissing(cluster_sizes);