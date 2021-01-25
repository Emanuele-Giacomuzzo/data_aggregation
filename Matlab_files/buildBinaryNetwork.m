function [A_clustered] = buildBinaryNetwork(membership,possible_connections,realised_connections,threshold)

A_clustered=zeros(max(membership));
for i=1:max(membership) 
    for j=1:max(membership)
        if realised_connections(i,j)/possible_connections(i,j)*100>threshold
            A_clustered(i,j)=1;
        end
    end
end

end