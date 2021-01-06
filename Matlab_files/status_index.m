function [outputArg1,outputArg2] = status_index(inputArg1,inputArg2)

path_length=getridofinf(distances(network_dir,'Method','unweighted'));
status=sum(path_length,2);
network_flipped=flipedge(network);
path_length_inv=getridofinf(distances(network_flipped,'Method','unweighted'));
controstatus=sum(path_length_inv,2);
net_status = status - controstatus;

end

