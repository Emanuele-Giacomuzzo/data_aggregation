function [status,controstatus,net_status] = status_index(A)
cd status_index;
network=digraph(A); 

path_length=getridofinf(distances(network,'Method','unweighted'));
status=sum(path_length,2);
network_flipped=flipedge(network);
path_length_inv=getridofinf(distances(network_flipped,'Method','unweighted'));
controstatus=sum(path_length_inv,2);
net_status = status - controstatus;

cd ..;
end