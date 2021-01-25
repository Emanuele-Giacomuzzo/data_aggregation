function[clusterID_densityModularity]=densityModularity(A)

A_db=tounweighted(A);
network=digraph(A);
indegreeSpecies=indegree(network);
outdegreeSpecies=outdegree(network);
m=numberoflinks(A);

[modules,B]=createmodulesandb(A_db);
B_matrix=modularitymatrix(A_db,indegreeSpecies,outdegreeSpecies,m);
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

clusterID_densityModularity=moduleofnodes(modules);
clusterID_densityModularity=changemodulenumber(clusterID_densityModularity);

end