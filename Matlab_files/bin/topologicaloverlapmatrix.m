function[node_overlap_m]=topologicaloverlapmatrix(interactor)

node_overlap_m=zeros(length(interactor));

for i=1:length(interactor)
    for j=1:length(interactor)
        for k=1:length(interactor)
            if (interactor(i,k)=='S') && (interactor(j,k)=='S')
                node_overlap_m(i,j)=node_overlap_m(i,j)+1;
            end
        end
    end
end

end