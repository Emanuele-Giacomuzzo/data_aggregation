function [branches] = createDendrogram(aggregation)

cd hierarchical_clustering;
A_db=tounweighted(A);

if aggregation=="jaccard" dissimilarity = pdist (A_db, 'jaccard'); end
if aggregation=="rege" dissimilarity = regeTransform(rege_similarity); end
best_linkage = chooseLinkageCriteria(dissimilarity);
branches = linkWithBestCriteria(dissimilarity,best_linkage);
cd ..

end