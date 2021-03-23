function[centrality_nodes]=assignNodeCentrality(clusters_centrality, membership)
%It is useful to go from the centrality of the clustered nodes to giving
%the same centrality to the single nodes. 

for node = 1:length(membership)
    centrality_nodes(node) = clusters_centrality(membership(node));
end

end