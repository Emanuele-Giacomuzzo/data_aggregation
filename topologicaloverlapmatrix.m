function[node_overlap_m]=topologicaloverlapmatrix(interactor)

s=0;
for c=1:length(interactor)
    for d=1:length(interactor)
        for r=1:length(interactor)
        if interactor(r,c)=='S'
            if interactor(r,d)=='S'
                node_overlap_m(c,d)=s+1;
            else 
                node_overlap_m(c,d)=0;
            end
        else node_overlap_m(c,d)=0;
        end
        end
    end
end

end