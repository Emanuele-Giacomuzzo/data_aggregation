function[bottom_up_keystone]=bottomupkeystone(adj_loopless,without_predators,nr_of_preys)

bottom_up=zeros(length(adj_loopless),1);

error=1;
while error >0
    for i=1:length(adj_loopless)
        if without_predators(i)==0;
            error=0;
            for j=1:length(adj_loopless)
                if adj_loopless(i,j)>0
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