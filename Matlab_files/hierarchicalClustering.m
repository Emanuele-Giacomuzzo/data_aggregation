function [cluster_nr,adj] = hierarchicalClustering(similarity,centrality,similarity_matrix)

cd hierarchical_clustering;

if similarity=="jaccard"
    dissimilarity = pdist (adj_dir_binary, 'jaccard');
elseif similarity=="rege" 
    dissimilarity = regeTransform(similarity_matrix);
end

best_linkage = chooseLinkageCriteria(dissimilarity);
linked = linkWithBestCriteria(best_linkage,dissimilarity);
[cluster_nr,adj] = bestClustering(adj_dir_binary,degree,jaccard_v,jaccard_linked); %wired

cd ..;
end

%Example
%similarity=rege
%centrality=degree
%similarity_matrix=REGE3