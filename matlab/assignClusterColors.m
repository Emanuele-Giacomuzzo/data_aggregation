function cluster_colors = assignClusterColors(membership)

clusters_color_mom = string.empty;
for node = 1:max(membership)
    if length(find(membership==node)) > 1
        cluster_colors(node) = "blue";
    else
        cluster_colors(node) = "red";
    end
end
cluster_colors = cluster_colors';

end