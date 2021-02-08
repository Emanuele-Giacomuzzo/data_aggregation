function [undirected_network] = toundirected(input_network)
%It preserves the self-loops.

if issymmetric(input_network)==0
    n=length(input_network);
    undirected_network=zeros(n);
    for i=1:n
        for j=1:n
            if input_network(i,j) ~= 0
                undirected_network(i,j)=input_network(i,j);
                undirected_network(j,i)=input_network(i,j);
            end
        end
    end
else
    undirected_network=input_network;
end

end