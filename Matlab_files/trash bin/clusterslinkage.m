function [adj_clustered] = clusterslinkage(adj_dir_binary, cluster_identity,realised_connections,possible_connections,link_percentage)

adj_clustered=zeros(max(cluster_identity));

for i=1:max(cluster_identity) 
    for j=1:max(cluster_identity)
        if realised_connections(i,j)/possible_connections(i,j)*100>link_percentage
            adj_clustered(i,j)=1;
        end
    end
end

end