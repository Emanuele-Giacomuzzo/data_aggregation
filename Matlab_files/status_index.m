function [status,controstatus,net_status] = status_index(network_dir)

cd status_index;

path_length=getridofinf(distances(network_dir,'Method','unweighted'));
status=sum(path_length,2);
network_flipped=flipedge(network_dir);
path_length_inv=getridofinf(distances(network_flipped,'Method','unweighted'));
controstatus=sum(path_length_inv,2);
net_status = status - controstatus;

cd ..;

end