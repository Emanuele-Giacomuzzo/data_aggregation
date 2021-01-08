function[cluster_nr_densityModularity]=densityBasedModularity(A)
cd modularity_maximisation;

A_db=tounweighted(A); 
network=digraph(A);
indegree_v=indegree(network);
outdegree_v=outdegree(network);
m=length(A);

m=numberoflinks(A);
[modules,B]=createmodulesandb(A_db);
B_matrix=modularitymatrix(A_db,indegree_v,outdegree_v,m);
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

cluster_nr_densityModularity=moduleofnodes(modules);
cluster_nr_densityModularity=changemodulenumber(cluster_nr_densityModularity);

cd ..;

end