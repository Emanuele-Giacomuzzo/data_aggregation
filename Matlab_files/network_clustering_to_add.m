
%Centralities for Jaccard clustered food web
centrality_between_Jac_clust=centrality(food_web_clustered,'betweenness');
centrality_between_Jac_nodes=centralityspecies(centrality_between_Jac_clust, cluster_identity);
rankings_for_different_data_aggregation=[centrality_between,centrality_between_Jac_nodes];
[p,tbl,stats] = friedman(rankings_for_different_data_aggregation);


%Pattern based modularity
%modules_patt=patternbasedmodularity(adj_dir_binary); %Not started
%adj_cluster_sbm=sbm(adj_dir_binary); %Not started

%Rege hierarchical clustering
%rege_m = regesimilarity (adj_dir_binary); rege_v = ?(rege_m); %Need rege matrix
%rege_average = linkage(rege_v, 'average'); %Need rege matrix
%cophenet_jac_average = cophenet(rege_average, rege_v); %Need rege matrix
%inconsistent_jac_average=inconsistent(rege_average); %Need rege matrix
%cluster_identity =cluster(rege_average,'cutoff',0.5); %Need rege matrix
%adj_cluster_rege=clusterslinkage(adj_dir_binary,cluster_identity,0.25); %Need rege matrix

%Keystone index
%centrality_keystone=keystone_index(adj_dir_weight);
%centrality_uniqueness=species_uniqueness(adj_dir_weight,centrality_overlap,0.1,1.0,0.1);


%Topological importance
%steps_matrix=stepsmatrix(adj_undir_binary, degree_m, 3);
%species_step_importance=speciesstepimportance(steps_matrix, 3);
%centrality_importance=centralityimportance(adj_undir_binary, species_step_importance, 3);