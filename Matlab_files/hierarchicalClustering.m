function [clusterID,A_clusters,centrality_nodes] = hierarchicalClustering(A, similarity,centrality_type,centrality_original,rege_similarity)
%This function finds the best way of using hierarchical clustering to
%preserve the pattern of a certain centrality measure. 
%
%[clusterID,A_clusters] = hierarchicalClustering(A, similarity,centrality_type,rege_similarity)
%
%A = adjacency matrix of the original food web
%similarity = jaccard/rege
%centrality_type = nDC/nwDC/nCC/nBC/...
%rege_similarity = rege similarity matrix (only if you use rege)

cd hierarchical_clustering;
A_db=tounweighted(A);

if similarity=="jaccard"
    dissimilarity = pdist (A_db, 'jaccard');
elseif similarity=="rege"
    dissimilarity = regeTransform(rege_similarity); %here's the problem
end

best_linkage = chooseLinkageCriteria(dissimilarity);
branches = linkWithBestCriteria(dissimilarity,best_linkage);
[clusterID,A_clusters,centrality_nodes] = bestClustering(A,branches,centrality_type,centrality_original);
cd ..;

end