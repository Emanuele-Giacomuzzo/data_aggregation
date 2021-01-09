function [clusterID,A_clusters] = hierarchicalClustering(A, similarity,centrality,rege_similarity)

cd hierarchical_clustering;
A_db=tounweighted(A);

if similarity=="jaccard"  dissimilarity = pdist (A_db, 'jaccard');
elseif similarity=="rege" dissimilarity = regeTransform(similarity);
end

best_linkage = chooseLinkageCriteria(dissimilarity);
branches = linkWithBestCriteria(dissimilarity,best_linkage);
[clusterID,A_clusters] = bestClustering(A,branches,similarity); %here gets confusing

cd ..;
end

%A = adjacency matrix
%similarity = jaccard/rege
%centrality = nDC/nwDC/nCC/nBC/...
%rege_similarity = rege similarity matrix (only if you use rege)
