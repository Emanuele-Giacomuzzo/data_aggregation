function [] = keystone_index(adj_dir_weight)

loopless=adj_dir_weight-diag(diag(adj_dir_weight));
bottom_up=zeros(length(loopless),1);
without_predators=zeros(length(loopless),1);
nr_of_preys=zeros(length(loopless),1);

for i=1:length(loopless)
    z=0;
    for j=1:length(loopless)
        if loopless(i,j)>0
            z=1;
        end
    end
    if z==0
        without_predators(i)=1;
    end
end

for i=1:length(loopless)
    for j=1:length(loopless)
        if loopless(i,j)>0
            nr_of_preys(j)=nr_of_preys(j)+1;
        end
    end
end

error=1;
while error >0
    for i=1:length(loopless)
        if without_predators(i)==0;
            error=0;
            for j=1:length(loopless)
                if loopless(i,j)>0
                    if (without_predators(j)==0) && (bottom_up(j)==0)
                        error=error+1;
                    else
                        bottom_up(i)=bottom_up(i)+(1/nr_of_preys(j))+(bottom_up(j)/nr_of_preys(j));
                    end
                    if error>0
                        bottom_up(i)=0;
                    else
                        a=1;
                    end
                else
                    a=1;
                end
            end
        else
            a=1;
        end
    end
end
end