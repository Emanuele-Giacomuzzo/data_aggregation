clc,clear,cd '/Users/ema/Documents/MATLAB/Data_aggregation';

load adj_dir_weight; % i (prey) -> j (predator)
load adj_dir_binary;
load adj_undir_weight;
load adj_undir_binary;
load node_names;

food_web=digraph(adj_dir_weight);
food_web_undir=graph(adj_undir_weight);

centrality_degree=centrality(food_web_undir,'degree');
centrality_close=centrality(food_web_undir,'closeness');
centrality_between=centrality(food_web,'betweenness');
centrality_importance=topological_importance(adj_undir_binary, food_web_undir, 3);

n_step=nstepmatrices(adj_dir_weight);
average_effect=averageeffect(adj_dir_weight,n_step);
interactor=interactormatrix(adj_dir_weight, average_effect, 0.1);
node_overlap_m=topologicaloverlapmatrix(interactor);
centrality_overlap=sum(node_overlap_m);

centrality_status = status_index(food_web);
centrality_controstatus = controstatusindex(food_web);
centrality_net_status = centrality_status - centrality_controstatus;

%centrality_keystone=keystone_index(adj_dir_weight);
%centrality_uniqueness=species_uniqueness(adj_dir_weight,centrality_overlap,0.1,1.0,0.1);

jaccard_v = pdist (adj_dir_binary, 'jaccard'); jaccard_matrix = squareform (jaccard_v);
jaccard_average = linkage(jaccard_v, 'average');
cophenet_jac_average = cophenet(jaccard_average, jaccard_v);
inconsistent_jac_average=inconsistent(jaccard_average);
cluster_identity =cluster(jaccard_average,'cutoff',0.5);

possible_connections=possibleconnections(adj_dir_binary,cluster_identity);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity);
adj_cluster_jaccard=clusterslinkage(adj_dir_binary,cluster_identity,realised_connections,possible_connections,0.25);

%rege_m = regesimilarity (adj_dir_binary); rege_v = ?(rege_m); %Need rege matrix
%rege_average = linkage(rege_v, 'average'); %Need rege matrix
%cophenet_jac_average = cophenet(rege_average, rege_v); %Need rege matrix
%inconsistent_jac_average=inconsistent(rege_average); %Need rege matrix
%cluster_identity =cluster(rege_average,'cutoff',0.5); %Need rege matrix
%adj_cluster_rege=clusterslinkage(adj_dir_binary,cluster_identity,0.25); %Need rege matrix

modules_dens=densitybasedmodularity(adj_dir_binary); %Not finished
modules_patt=patternbasedmodularity(adj_dir_binary); %Not started

adj_cluster_sbm=sbm(adj_dir_binary); %Not started

[p,tbl,stats] = friedman(rankings_for_different_data_aggregation);

a=input('Would you like to see how the original food web looks like? [sure bro/nah bro]: ','s');
if a=='sure bro'
plot(food_web,'NodeLabel',node_names);
end
a=input('Would you like to see the dendrogram of Jaccard similarities? [sure bro/nah bro]: ','s');
if a=='sure bro'
dendrogram(jaccard_average, 63,'Orientation','left','Labels',node_names);
end