function[cluster_size]=clustersize(cluster_identity)

cluster_size=zeros(max(cluster_identity),1);

for i=1:length(cluster_identity)
    a=cluster_identity(i);
    cluster_size(a)=cluster_size(a)+1;
end

end