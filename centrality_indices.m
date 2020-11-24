betweenness=centrality(graph,'betweenness');
indegree=centrality(graph,'indegree');
outdegree=centrality(graph,'outdegree');
incloseness=centrality(graph,'incloseness');
outcloseness=centrality(graph,'outcloseness');

status = status_index(graph);
controstatus = controstatus_index(graph);
net_status = status - controstatus;

threshold_v=[0.01:0.01:0.1];
for i=1:length(threshold_v)
    node_overlap_v{i}=topological_overlap(weighted_network,threshold_v(i));
end

species_uniqueness=zeros([1 length(node_overlap_v{1})]);
for i=1:length(threshold_v)
    species_uniqueness = species_uniqueness + node_overlap_v{i};
end

