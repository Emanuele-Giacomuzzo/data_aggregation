function[possible_connections]=possibleConnections(cluster_size)

possible_connections=zeros(max(cluster_size));

for i=1:length(cluster_size)
    for j=1:length(cluster_size)
        possible_connections(i,j)=cluster_size(i)*cluster_size(j);
    end
    possible_connections(i,i)=0;
end

end