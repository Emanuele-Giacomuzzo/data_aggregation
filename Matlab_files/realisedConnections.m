function[realised_connections]=realisedConnections(A, membership)

realised_connections=zeros(max(membership));
for i=1:length(realised_connections)
    for j=1:length(realised_connections)
        for k=1:length(A)
            for l=1:length(A)
                if membership(k) == i && membership(l) == j && A(k,l) ~=0
                    realised_connections(i,j)=realised_connections(i,j)+1;
                end
            end
        end
    end
end

end