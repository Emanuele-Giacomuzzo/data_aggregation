function [branches] = findBranches(A,similarity,rege_similarity)
%A=adjacency matrix (DW)
%similarity=tpye of similarity
cd hierarchical_clustering;

A_db=tounweighted(A);
if similarity=="jaccard"
    dissimilarity = pdist (A_db, 'jaccard');
elseif similarity=="rege"
    dissimilarity = regeTransform(rege_similarity); %here's the problem
end

best_linkage = chooseLinkageCriteria(dissimilarity);
branches = linkWithBestCriteria(dissimilarity,best_linkage);

cd ..;
end