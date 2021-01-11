function [best_linkage] = chooseLinkageCriteria(dissimilarity_v)

cluster_single = linkage(dissimilarity_v, 'average');
cluster_complete = linkage(dissimilarity_v, 'complete');
cluster_average = linkage(dissimilarity_v, 'average');
cluster_weighted = linkage(dissimilarity_v, 'weighted');
cluster_centroid = linkage(dissimilarity_v, 'centroid');
cluster_median = linkage(dissimilarity_v, 'median');
cluster_ward = linkage(dissimilarity_v, 'ward');

linkage_names=["single","complete","average","weighted","centroid","median","ward"];

linkage_cophenetic(1)=cophenet(cluster_single,dissimilarity_v);
linkage_cophenetic(2)=cophenet(cluster_complete,dissimilarity_v);
linkage_cophenetic(3)=cophenet(cluster_average,dissimilarity_v);
linkage_cophenetic(4)=cophenet(cluster_weighted,dissimilarity_v);
linkage_cophenetic(5)=cophenet(cluster_centroid,dissimilarity_v);
linkage_cophenetic(6)=cophenet(cluster_median,dissimilarity_v);
linkage_cophenetic(7)=cophenet(cluster_ward,dissimilarity_v);

[M,I]=max(linkage_cophenetic); %What if there are multiple ones?
best_linkage=linkage_names(I);

end