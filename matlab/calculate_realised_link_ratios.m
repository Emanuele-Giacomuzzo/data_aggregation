%% INITIALISE
realised_link_ratio = cell(length(clustering_methods),1);

%% CALCULATE THE REALISED LINK RATIOS
for clustering = 1:length(clustering_methods)
    cluster_size = findClusterSize(membership{web,clustering});
    possible_links = findPossibleLinks(cluster_size);
    realised_links = findRealisedLinks(A,membership{web,clustering});
    realised_link_ratio{clustering} = findRealisedLinkRatio(possible_links, realised_links);
end