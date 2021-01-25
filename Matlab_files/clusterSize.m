function[cluster_size]=clusterSize(membership)

cluster_size=zeros(max(membership),1);

for i=1:length(membership)
    a=membership(i);
    cluster_size(a)=cluster_size(a)+1;
end

end