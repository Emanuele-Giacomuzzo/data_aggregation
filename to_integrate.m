%centrality_keystone=keystone_index(adj_dir_weight);


%jaccard_complete = linkage(jaccard_vector, 'complete');
%jaccard_average = linkage(jaccard_vector, 'average');
%jaccard_weighted = linkage(jaccard_vector, 'weighted');
%jaccard_centroid = linkage(jaccard_vector, 'centroid');
%jaccard_median = linkage(jaccard_vector, 'median');
%jaccard_ward = linkage(jaccard_vector, 'ward');

%dendrogram(jaccard_complete, 63,'Orientation','left','Labels',node_names);
%dendrogram(jaccard_average, 63,'Orientation','left','Labels',node_names);
%dendrogram(jaccard_weighted, 63,'Orientation','left','Labels',node_names);
%dendrogram(jaccard_centroid, 63,'Orientation','left','Labels',node_names);
%dendrogram(jaccard_median, 63,'Orientation','left','Labels',node_names);
%dendrogram(jaccard_ward, 63,'Orientation','left','Labels',node_names);

%cophenet_jac_complete = cophenet(jaccard_complete, jaccard_vector);
%cophenet_jac_average = cophenet(jaccard_average, jaccard_vector);
%cophenet_jac_weighted = cophenet(jaccard_weighted, jaccard_vector);
%cophenet_jac_centroid = cophenet(jaccard_centroid, jaccard_vector);
%cophenet_jac_median = cophenet(jaccard_median, jaccard_vector);
%cophenet_jac_ward = cophenet(jaccard_ward, jaccard_vector);

%inconsistent_jac_complete=inconsistent(jaccard_complete);
%inconsistent_jac_average=inconsistent(jaccard_average);
%inconsistent_jac_weighted=inconsistent(jaccard_weighted);
%inconsistent_jac_centroid=inconsistent(jaccard_centroid);
%inconsistent_jac_median=inconsistent(jaccard_median);
%inconsistent_jac_ward=inconsistent(jaccard_ward);

%stochastic block modelling

%directed modularity