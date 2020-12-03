function [adj_clustered] = clusterslinkage(adj_dir_binary, cluster_identity,link_fraction)

adj_clustered=zeros(max(cluster_identity));
possible_connections=zeros(max(cluster_identity));
realised_connections=zeros(max(cluster_identity));

for i=1:max(cluster_identity) 
    for j=1:max(cluster_identity) 
        for k=1:length(adj_dir_binary) 
            if cluster_identity(k)==i 
                for l=1:length(adj_dir_binary)
                    if cluster_identity(l)==j 
                        possible_connections(i,j)=possible_connections(i,i)+1;
                    else
                        possible_connections(i,j)=possible_connections(i,i);
                    end
                    if adj_dir_binary(k,l)>0
                        realised_connections(i,j)=realised_connections(i,j)+1;
                    else
                        realised_connections(i,j)=realised_connections(i,j);
                    end
                end
            end
        end
        if realised_connections(i,j)/possible_connections(i,j)>link_fraction
            adj_clustered(i,j)=1;
        else
            adj_clustered(i,j)=0;
        end
    end
end

end