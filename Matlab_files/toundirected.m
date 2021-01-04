function [undirected_network] = toundirected(directed_network)

loopless_network=directed_network-diag(diag(directed_network));

for i=1:length(loopless_network)
    for j=1:length(loopless_network)
        if loopless_network(i,j) > 0    
            undirected_network(i,j)=loopless_network(i,j);
            undirected_network(j,i)=loopless_network(i,j);
        end
    end
end

end