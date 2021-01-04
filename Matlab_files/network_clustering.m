clc,clear,cd '/Users/ema/Documents/MATLAB/Data_aggregation';
load adj_dir_weight; % i (prey) -> j (predator)
load node_names;

adj_dir_binary=tounweighted(adj_dir_weight);
adj_und_weight=toundirected(adj_dir_weight);
adj_und_binary=toundirected(adj_dir_binary);

network_dir=digraph(adj_dir_weight);
network_und=graph(adj_und_weight);
n=length(adj_dir_weight);

degree=centrality(network_und,'degree')/(n-1);
weighted_degree=weightedDegree(adj_dir_weight)/(n-1);
closeness=centrality(network_und,'closeness')*(n-1);
betweenness=centrality(network_dir,'betweenness')/[(n-1)*(n-2)/2];

%Topological overlap 
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

%Status index 
path_length=getridofinf(distances(network_dir,'Method','unweighted'));
status=sum(path_length,2);
network_flipped=flipedge(network);
path_length_inv=getridofinf(distances(network_flipped,'Method','unweighted'));
controstatus=sum(path_length_inv,2);
net_status = status - controstatus;