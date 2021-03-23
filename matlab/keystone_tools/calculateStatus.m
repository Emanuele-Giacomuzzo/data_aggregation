function [s,cs,ns] = statusIndices(A)
%Network: binary, directed, loop-less. This code was tested against
%CosbiLab results. 

%Watch out: the food web you are using needs to be loopless: it doesn't
%need to contain neither self-loops or simple cycles.

A(A > 0) = 1; %binary

path_length = distances(digraph(A),'Method','unweighted');
path_length(isinf(path_length)) = 0;
s = sum(path_length,2);

path_length_inv = distances(flipedge(digraph(A)),'Method','unweighted');
path_length_inv(isinf(path_length_inv)) = 0;
cs = sum(path_length_inv,2);

ns = s - cs;

end