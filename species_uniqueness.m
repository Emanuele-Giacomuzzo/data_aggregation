function [centrality_uniqueness] = species_uniqueness(adj_weighted, centrality_overlap, min_threshold, max_threshold, learning_rate)

centrality_uniqueness=zeros([1 length(centrality_overlap{1})]);
threshold_v=[min_threshold:learning_rate:max_threshold];

for i=1:length(threshold_v)
    centrality_overlap{i}=topological_overlap(adj_weighted,threshold_v(i));
end
for i=1:length(threshold_v)
    centrality_uniqueness = centrality_uniqueness + centrality_overlap{i};
end

end


