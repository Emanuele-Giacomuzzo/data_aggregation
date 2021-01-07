function[adj_cluster_mod_den]=densityBasedModularity(adj_dir_weight)

n=length(adj_dir_weight);

%Density-based modularity
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
end