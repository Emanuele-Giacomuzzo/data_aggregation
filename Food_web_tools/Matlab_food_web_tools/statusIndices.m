function [s,cs,ns] = statusIndices(A)
A_db=tounweighted(A);
network=digraph(A_db); 

path_length=getridofinf(distances(network,'Method','unweighted'));
s=sum(path_length,2);
network_flipped=flipedge(network);
path_length_inv=getridofinf(distances(network_flipped,'Method','unweighted'));
cs=sum(path_length_inv,2);
ns = s - cs;

end