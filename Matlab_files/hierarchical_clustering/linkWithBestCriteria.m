function [branches] = linkWithBestCriteria(best_linkage, dissimilarity_vector)

if best_linkage=="single" branches = linkage(dissimilarity_vector, 'single'); end
if best_linkage=="complete" branches = linkage(dissimilarity_vector, 'complete'); end
if best_linkage=="average" branches = linkage(dissimilarity_vector, 'average'); end
if best_linkage=="weighted" branches = linkage(dissimilarity_vector, 'weighted'); end
if best_linkage=="centroid" branches = linkage(dissimilarity_vector, 'centroid'); end
if best_linkage=="median" branches = linkage(dissimilarity_vector, 'median'); end
if best_linkage=="ward" branches = linkage(dissimilarity_vector, 'ward'); end

end