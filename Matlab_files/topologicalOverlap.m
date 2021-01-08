function [overlap,overlap_ratio]=topologicalOverlap(A,nr_of_steps,threshold)
cd topological_overlap;

A_db=tounweighted(A);  
A_ub=toundirected(A_db);
A_uw=toundirected(A);
network_U=graph(A_uw);

degree_m=degreematrix(A_ub, network_U);

n_step=onestepeffect(A, degree_m); %It's the same as for topological importance
n_step=stepeffectoverlap(A,n_step, nr_of_steps);

average_effect=averageeffect(A,n_step, nr_of_steps);
interactor=interactormatrix(average_effect, threshold);

node_overlap_m=topologicaloverlapmatrix(interactor);

overlap=sum(node_overlap_m,2);
overlap_ratio=overlap/sum(overlap);

cd ..;

end