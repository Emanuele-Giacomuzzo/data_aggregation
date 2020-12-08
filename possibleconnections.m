function[possible_connections]=possibleconnections(adj_dir_binary,cluster_identity)

possible_connections=zeros(max(cluster_identity));

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
                end
            end
        end
    end
end

end