function [centrality_uniqueness] = species_uniqueness(adj_weighted, min_threshold, max_threshold, learning_rate)

threshold_v=[min_threshold:learning_rate:max_threshold];
for i=1:length(threshold_v)
    node_overlap_v{i}=topological_overlap(adj_weighted,threshold_v(i));
end

centrality_uniqueness=zeros([1 length(node_overlap_v{1})]);
for i=1:length(threshold_v)
    centrality_uniqueness = centrality_uniqueness + node_overlap_v{i};
end

end