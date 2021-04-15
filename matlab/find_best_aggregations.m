%% INITIALISE
best_kendall = zeros(length(centralities),length(clustering_methods));
best_link_n_strength = zeros(length(centralities),length(clustering_methods));
ci_min_of_best = zeros(length(centralities),length(clustering_methods));
ci_max_of_best = zeros(length(centralities),length(clustering_methods));

%% FIND BEST AGGREGATIONS
for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(kendall_mean{clustering})
        [best_kendall(centralityI,clustering), best_link_n_strength(centralityI,clustering)] = max(kendall_mean{clustering}(centralityI,:));
        ci_min_of_best(centralityI,clustering) = kendall_ci_min{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
        ci_max_of_best(centralityI,clustering) = kendall_ci_max{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
    end
end
ci_min_of_best = round(ci_min_of_best,2);
ci_max_of_best = round(ci_max_of_best,2);