function[m]=numberoflinks(adj_dir)

m=0;

for i=1:length(adj_dir)
    for j=1:length(adj_dir)
        if adj_dir(i,j)>0
            m=m+1;
        end
    end
end

end