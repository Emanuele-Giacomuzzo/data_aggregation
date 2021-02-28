function [unweighted_network] = tounweighted(weighted_network)
%It preserves the self-loops.

n=length(weighted_network);
unweighted_network=zeros(n);
for i=1:n
    for j=1:n
        if weighted_network(i,j)==0;
            unweighted_network(i,j)=0;
        else
            unweighted_network(i,j)=1;
        end
    end
end

end