function [linked] = linkWithBestCriteria(best_linkage, dissimilarity_vector)

if best_linkage=="single" linked = linkage(dissimilarity_vector, 'single'); end
if best_linkage=="complete" linked = linkage(dissimilarity_vector, 'complete'); end
if best_linkage=="average" linked = linkage(dissimilarity_vector, 'average'); end
if best_linkage=="weighted" linked = linkage(dissimilarity_vector, 'weighted'); end
if best_linkage=="centroid" linked = linkage(dissimilarity_vector, 'centroid'); end
if best_linkage=="median" linked = linkage(dissimilarity_vector, 'median'); end
if best_linkage=="ward" linked = linkage(dissimilarity_vector, 'ward'); end

end