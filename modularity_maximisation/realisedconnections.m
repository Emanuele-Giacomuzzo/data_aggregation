function[realised_connections]=realisedconnections(adj_dir_binary, cluster_identity, link_percentage)

realised_connections=zeros(max(cluster_identity));

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if adj_dir_binary(i,j)>0
            k=cluster_identity(i);
            l=cluster_identity(j);
            realised_connections(k,l)=realised_connections(k,l)+1;
        end
    end
end

end