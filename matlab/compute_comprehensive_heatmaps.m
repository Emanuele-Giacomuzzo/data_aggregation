all_mean_kendalls = double.empty;
all_max_ci = double.empty;
all_min_ci = double.empty;

for clustering = 1:length(clustering_methods)
    all_mean_kendalls = [all_mean_kendalls kendall_mean{clustering}];
    all_max_ci = [all_max_ci kendall_ci_max{clustering}];
    all_min_ci = [all_min_ci kendall_ci_min{clustering}];
end
all_max_ci = all_max_ci - all_mean_kendalls;
all_min_ci = all_mean_kendalls - all_min_ci;