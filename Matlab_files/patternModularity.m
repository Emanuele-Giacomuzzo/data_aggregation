function[cluster_identity_patternModularity]=patternBasedModularity(A)
%Here I refer to the total number of species in the network as m instead of
%n. This is to conform to the notation used by Leicht & Newman 2008
%(Community structure in directed networks) and to not create confusion. 
cd modularity_maximisation;

A_db=tounweighted(A);
network=digraph(A);
indegree_v=indegree(network);
outdegree_v=outdegree(network);
m=length(A);

[modules,B]=createmodulesandb(A_db);
c_out=sharedOutLink(A_db);
in_times_in_minus_one=inTimesInMinusOne(indegree_v);
B_matrix_patt=modularityMatrixPattern(A_db,c_out,in_times_in_minus_one,outdegree_v,indegree_v);
B{1}=B_matrix_patt;
s=svector(B,1);
Q=(1/4*m)*s'*(B{1}+B{1}')*s;
[Q,s]=finetune(Q,B,s,m,1);
modules{2}=modulecomposition(s,1);
modules{3}=modulecomposition(s,0);
for z=2:length(modules)
    B{z}=modularitysubmatrix(modules,B_matrix_patt,z);
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
cluster_identity_patternModularity=moduleofnodes(modules);
cluster_identity_patternModularity=changemodulenumber(cluster_identity_patternModularity);

cd ..;

end