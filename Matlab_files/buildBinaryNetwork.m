function [A_clustered] = buildBinaryNetwork(cluster_ID,possible_connections,realised_connections,threshold)

for i=1:max(cluster_ID) 
    for j=1:max(cluster_ID)
        if realised_connections(i,j)/possible_connections(i,j)*100>threshold
            A_clustered(i,j)=1;
        end
    end
end

end