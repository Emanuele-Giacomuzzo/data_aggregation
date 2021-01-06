function[]=topologicalOverlap()

nr_of_steps=4;
threshold=0.01;

degree_m=degreematrix(adj_und_binary, network_und);

n_step=onestepeffect(adj_dir_weight, degree_m); %It's the same as for topological importance
n_step=stepeffectoverlap(adj_dir_weight,n_step, nr_of_steps);

average_effect=averageeffect(adj_dir_weight,n_step, nr_of_steps);
interactor=interactormatrix(average_effect, threshold);

node_overlap_m=topologicaloverlapmatrix(interactor);

overlap=sum(node_overlap_m,2);
overlap_ratio=overlap/sum(overlap);

%Weighted topological overlap
nr_of_steps=4;
threshold=0.01;
weighted_one_step=weightedOneStep(adj_dir_weight);

end