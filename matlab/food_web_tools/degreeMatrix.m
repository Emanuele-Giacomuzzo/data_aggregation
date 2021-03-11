function [degree_m] = degreeMatrix (A,weight)

if weight == "binary"
    A_uw = toundirected(A);
    A_ub = tounweighted(A_uw);
    network_U = graph(A_ub);
    
    degree_v = degree(network_U);
    for i = 1:length(A_ub)
        degree_m(i,i) = degree_v(i);
    end
    
elseif weight == "weighted"
    degree_v = weightedDegree(A);
    degree_m = zeros(length(A));
    for i = 1:length(degree_v)
        for j = 1:length(degree_v)
            degree_m(i,i) = degree_v(i);
        end
    end
end


end