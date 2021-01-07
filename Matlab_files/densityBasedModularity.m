function[cluster_identity_densityModularity]=densityBasedModularity(adj_dir_weight, adj_dir_binary)

cd modularity_maximisation;

network_dir=digraph(adj_dir_weight);
indegree_v=indegree(network_dir);
outdegree_v=outdegree(network_dir);
m=length(adj_dir_weight);

m=numberoflinks(adj_dir_weight);
[modules,B]=createmodulesandb(adj_dir_binary);
B_matrix=modularitymatrix(adj_dir_binary,indegree_v,outdegree_v,m);
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

cluster_identity_densityModularity=moduleofnodes(modules);
cluster_identity_densityModularity=changemodulenumber(cluster_identity_densityModularity);

cd ..;

end