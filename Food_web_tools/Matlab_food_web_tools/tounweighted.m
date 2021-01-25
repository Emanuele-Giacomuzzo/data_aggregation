function [unweighted_network] = tounweighted(weighted_network)

for i=1:length(weighted_network)
    for j=1:length(weighted_network)
        if weighted_network(i,j)== 0;
            unweighted_network(i,j)=0;
        else
            unweighted_network(i,j)=1;
    end
    end
end
end