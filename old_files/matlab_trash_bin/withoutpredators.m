function [without_predators]=withoutpredators(adj_loopless)

without_predators=zeros(length(adj_loopless),1);



for i=1:length(adj_loopless)
    z=0;
    for j=1:length(adj_loopless)
        if adj_loopless(i,j)>0
            z=1;
        end
    end
    if z==0
        without_predators(i)=1;
    end
end

end