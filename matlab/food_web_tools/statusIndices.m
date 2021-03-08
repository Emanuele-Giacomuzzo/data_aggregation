function [s,cs,ns] = statusIndices(A)
%Network: binary, directed, loop-less. This code was tested against
%CosbiLab results. 

%Watch out: the food web you are using needs to be loopless: it doesn't
%need to contain neither self-loops or simple cycles.

A_db = tounweighted(A); %binary
network = digraph(A_db);

path_length = getridofinf(distances(network,'Method','unweighted'));
s = sum(path_length,2);
network_flipped = flipedge(network);
path_length_inv = getridofinf(distances(network_flipped,'Method','unweighted'));
cs = sum(path_length_inv,2);
ns = s - cs;

end