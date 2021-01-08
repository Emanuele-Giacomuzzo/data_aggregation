function [best_linkage] = chooseLinkageCriteria(rege_dissimilarity_v)

rege_single = linkage(rege_dissimilarity_v, 'average');
rege_complete = linkage(rege_dissimilarity_v, 'complete');
rege_average = linkage(rege_dissimilarity_v, 'average');
rege_weighted = linkage(rege_dissimilarity_v, 'weighted');
rege_centroid = linkage(rege_dissimilarity_v, 'centroid');
rege_median = linkage(rege_dissimilarity_v, 'median');
rege_ward = linkage(rege_dissimilarity_v, 'ward');

linkage_names=["single","complete","average","weighted","centroid","median","ward"];

linkage_cophenetic(1)=cophenet(rege_single,rege_dissimilarity_v);
linkage_cophenetic(2)=cophenet(rege_complete,rege_dissimilarity_v);
linkage_cophenetic(3)=cophenet(rege_average,rege_dissimilarity_v);
linkage_cophenetic(4)=cophenet(rege_weighted,rege_dissimilarity_v);
linkage_cophenetic(5)=cophenet(rege_centroid, rege_dissimilarity_v);
linkage_cophenetic(6)=cophenet(rege_median, rege_dissimilarity_v);
linkage_cophenetic(7)=cophenet(rege_ward, rege_dissimilarity_v);

[M,I]=max(linkage_cophenetic); %What if there are multiple ones?
best_linkage=linkage_names(I);

end