%% INITIALISE 
rankings = strings(length(centralities),length(clustering_methods));
rankings_ci = strings(length(centralities),length(clustering_methods));
rankings_link_n_strength = strings(length(centralities),length(clustering_methods));

%% RANK BEST AGGREGATION 
for centralityI = 1:length(best_kendall)
    [sorted_values, sorted_values_indices] = sort(best_kendall(centralityI,:),'descend');
    sorted_values = round(sorted_values,2);
    for rank = 1:length(clustering_methods)
        rankings(centralityI,rank) = "A" + sorted_values_indices(rank) + " (" + sprintf('%1.2f',sorted_values(rank)) + ")";
        rankings_ci(centralityI,rank) = "A" + sorted_values_indices(rank) + " (" + sprintf('%1.2f', ci_min_of_best(centralityI,sorted_values_indices(rank))) + "-" + sprintf('%1.2f',ci_max_of_best(centralityI,sorted_values_indices(rank))) + ")";
        rankings_link_n_strength(centralityI,rank) = "A" + sorted_values_indices(rank) + " " + "M" + best_link_n_strength(centralityI,sorted_values_indices(rank)) + " )";
    end
end

%% Change the names

for clustering = 1:length(clustering_methods)
    rankings = strrep(rankings, "A"+clustering, clustering_better_names(clustering));
    rankings_ci = strrep(rankings_ci, "A"+clustering, clustering_better_names(clustering));
    rankings_link_n_strength = strrep(rankings_link_n_strength, "A"+clustering, clustering_better_names(clustering));
end

for method = 1:length(linkage_n_strength)
    rankings_link_n_strength = strrep(rankings_link_n_strength, "M"+method+" ", linkage_n_strength(method));
end

%% If the centralityI index is not a weighted one, delete the strength part.
for centralityI = 1:length(centralities)
    if isempty(find(weighted_centralities==centralityI)) == 1;
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"min","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"max","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"sum","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"mean","");
    end
end