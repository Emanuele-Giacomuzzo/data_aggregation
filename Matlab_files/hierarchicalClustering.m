function [cluster_nr,A] = hierarchicalClustering(similarity,centrality,similarity)

cd hierarchical_clustering;

if similarity=="jaccard"
    dissimilarity = pdist (A_DB, 'jaccard');
elseif similarity=="rege" 
    dissimilarity = regeTransform(similarity);
end

best_linkage = chooseLinkageCriteria(dissimilarity);
linked = linkWithBestCriteria(best_linkage,dissimilarity);
[cluster_nr,A] = bestClustering(A_DB,degree,jaccard,linked);

cd ..;
end

%Example
%similarity=rege
%centrality=degree
%similarity=REGE3