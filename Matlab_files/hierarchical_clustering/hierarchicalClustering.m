function [A_clusters,centrality_clusters,clusterID,best_link,best_th] = hierarchicalClustering(A, aggregation,centrality_type,centrality_original,rege_similarity)

cd hierarchical_clustering;
A_db=tounweighted(A);

%Create the dendrogram 
if aggregation=="jaccard" dissimilarity = pdist (A_db, 'jaccard'); end
if aggregation=="rege" dissimilarity = regeTransform(rege_similarity); end
best_linkage = chooseLinkageCriteria(dissimilarity);
branches = linkWithBestCriteria(dissimilarity,best_linkage);
%Cluster the nodes
[clusterID,A_clusters,centrality_clusters,best_th,best_link] = bestClustering(A,branches,centrality_type,centrality_original);
cd ..;

end