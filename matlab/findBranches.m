function branches = findBranches(A, similarity, rege_similarity)
%This function finds the branches according to the similarity we decide and
%to the method that produces the highest cophenetic correlation. 

A(A > 0) = 1;

if similarity == "jaccard"
    dissimilarity = pdist (A, 'jaccard');
elseif similarity == "rege"
    dissimilarity = transformRegeMatrix(rege_similarity);
end

best_linkage = chooseLinkageCriteria(dissimilarity);
branches = useLinkageWithBestCriteria(dissimilarity,best_linkage);

end