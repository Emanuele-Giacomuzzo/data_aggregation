function [degree_m] = degreeMatrix (A)

A_uw=toundirected(A);
A_ub=tounweighted(A_uw);
network_U=graph(A_ub);

degree_v=degree(network_U);
for i=1:length(A_ub)
    degree_m(i,i)= degree_v(i);
end

end