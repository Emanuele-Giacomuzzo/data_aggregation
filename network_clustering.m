clc,clear,cd '/Users/ema/Documents/MATLAB/Data_aggregation';
load adj_dir_weight; % i (prey) -> j (predator)
load node_names;

adj_dir_binary=tounweighted(adj_dir_weight);
adj_undir_weight=toundirected(adj_dir_weight);
adj_undir_binary=toundirected(adj_dir_binary);

food_web=digraph(adj_dir_weight);
food_web_undir=graph(adj_undir_weight);

%Centrality
centrality_degree=centrality(food_web_undir,'degree');
centrality_close=centrality(food_web_undir,'closeness');
centrality_between=centrality(food_web,'betweenness');

%Topological overlap 
nr_of_steps=4;
threshold=0.01;
degree_m=degreematrix(adj_undir_binary, food_web_undir);
n_step=onestepeffect(adj_dir_weight, degree_m); %It's the same as for topological importance
n_step=stepeffectoverlap(adj_dir_weight,n_step, nr_of_steps);
average_effect=averageeffect(adj_dir_weight,n_step, nr_of_steps);
interactor=interactormatrix(average_effect, threshold);
node_overlap_m=topologicaloverlapmatrix(interactor);
centrality_overlap=sum(node_overlap_m,2);

%Status index 
path_length=distances(food_web,'Method','unweighted');
path_length=getridofinf(path_length);
centrality_status=sum(path_length,2);
food_web_flipped=flipedge(food_web);
path_length_inv=distances(food_web_flipped,'Method','unweighted');
path_length_inv=getridofinf(path_length_inv);
centrality_controstatus=sum(path_length_inv,2);
centrality_net_status = centrality_status - centrality_controstatus;

%Jaccard clustering
threshold=0.5;
link_percentage=0.25;
jaccard_v = pdist (adj_dir_binary, 'jaccard');
jaccard_average = linkage(jaccard_v, 'average');
cluster_identity_jac =cluster(jaccard_average,'cutoff',threshold);
cluster_size_jac=clustersize(cluster_identity_jac);
possible_connections=possibleconnections(cluster_size);
realised_connections=realisedconnections(adj_dir_binary,cluster_identity_jac);
adj_cluster_jaccard=clusterslinkage(adj_dir_binary,cluster_identity_jac,realised_connections,possible_connections,link_percentage);
food_web_clustered=digraph(adj_cluster_jaccard);

%Density based modularity
m=numberoflinks(adj_dir_weight);
indegree=nodeindegree(adj_dir_binary);
outdegree=nodeoutdegree(adj_dir_binary);
[modules,B]=createmodulesandb(adj_dir_binary);
B_matrix=modularitymatrix(adj_dir_binary,indegree,outdegree,m);
B{1}=B_matrix;
s=svector(B,1);
Q=(1/4*m)*s'*(B{1}+B{1}')*s;
[Q,s]=finetune(Q,B,s,m,1);
modules{2}=modulecomposition(s,1);
modules{3}=modulecomposition(s,0);
for z=2:length(modules)
    B{z}=modularitysubmatrix(modules,B_matrix,z);
    s=svector(B,z);
    [Q,s]=finetune(Q,B,s,m,z);
    for i=1:length(modules)
        if sum(modules{i})==0
            modules{i}=modulecomposition(s,1);
            break
        end
    end
    for i=1:length(modules)
        if sum(modules{i})==0
            modules{i}=modulecomposition(s,0);
            break
        end
    end
end
cluster_identity_mod_den=moduleofnodes(modules);
module_number_new=changemodulenumber(cluster_identity_mod_den);
cluster_size_dens_modul=clustersize(module_number_new);
possible_connections_mod_den=possibleconnections(cluster_size_dens_modul);
realised_connections_mod_den=realisedconnections(adj_dir_binary,module_number_new);
adj_cluster_mod_den=clusterslinkage(adj_dir_binary,module_number_new,realised_connections_mod_den,possible_connections_mod_den,link_percentage);
food_web_clust_mod_den=digraph(adj_cluster_mod_den);