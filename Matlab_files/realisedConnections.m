function[realised_connections]=realisedConnections(A, membership)

A_db=tounweighted(A);

realised_connections=zeros(max(membership));

for i=1:length(A_db)
    for j=1:length(A_db)
        if A_db(i,j)>0
            k=membership(i);
            l=membership(j);
            realised_connections(k,l)=realised_connections(k,l)+1;
        end
    end
end

end