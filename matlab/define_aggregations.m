clustering_methods = [ "jaccard_similarity" "rege_similarity" "density_modularity" "prey_modularity" "predator_modularity" "group_model"]; 
clustering_better_names = ["Jaccard" "REGE" "density" "prey" "predator" "groups"];

linkage_methods = [0.001; 0.25 ; 0.5 ; 0.75 ; 1];
linkage_methods_names = ["NMAX" "25%" "50%" "75%" "NMIN"];
strength_methods = ["min" "mean" "max" "sum"];

linkage_n_strength = string.empty;
for linkage = 1:length(linkage_methods)
    for strength = 1:length(strength_methods)
        linkage_n_strength = [linkage_n_strength; [string(linkage_methods_names(linkage)) + " " + strength_methods(strength)]];
    end
end

aggregation_methods = string.empty;
for clustering = 1:length(clustering_methods)
    for links = 1:length(linkage_n_strength)
       aggregation_methods = [aggregation_methods; (linkage_n_strength(links) + "  " + clustering_better_names(clustering))];
    end
end