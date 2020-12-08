function[realised_connections]=realisedconnections(adj_dir_binary, cluster_identity)

realised_connections=zeros(max(cluster_identity));

for i=1:max(cluster_identity) 
    for j=1:max(cluster_identity) 
        for k=1:length(adj_dir_binary) 
            if cluster_identity(k)==i 
                for l=1:length(adj_dir_binary)
                    if adj_dir_binary(k,l)>0
                        realised_connections(i,j)=realised_connections(i,j)+1;
                    else
                        realised_connections(i,j)=realised_connections(i,j);
                    end
                end
            end
        end
    end
end

end