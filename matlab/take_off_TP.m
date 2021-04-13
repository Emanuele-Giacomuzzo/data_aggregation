if take_off_TP == 1
    
    centralities_latex = centralities_latex(1:end-1,:);
    all_mean_kendalls = all_mean_kendalls(1:end-1,:);
    all_max_ci = all_max_ci(1:end-1,:);
    all_min_ci = all_min_ci(1:end-1,:);
    best_kendall = best_kendall(1:end-1,:);
    
    for clustering = 1:length(clustering_methods)
        kendall_mean{clustering} = kendall_mean{clustering}(1:end-1,:);
        kendall_ci_max_relative{clustering} = kendall_ci_max_relative{clustering}(1:end-1,:);
        kendall_ci_min_relative{clustering} = kendall_ci_min_relative{clustering}(1:end-1,:);
    end
    
end