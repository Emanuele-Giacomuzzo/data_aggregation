for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(centralities)
        for strength_n_ratio = 1:length(linkage_n_strength)
            fisher{clustering}{centralityI,strength_n_ratio} = atanh(kendalls_rearranged{clustering}{centralityI,strength_n_ratio});
            fisher_mean{clustering}(centralityI,strength_n_ratio) = mean(fisher{clustering}{centralityI,strength_n_ratio});
            fisher_ci_min{clustering}(centralityI,strength_n_ratio) = min(bootci(length(fisher{clustering}{centralityI,strength_n_ratio}),@mean,fisher{clustering}{centralityI,strength_n_ratio}));
            fisher_ci_max{clustering}(centralityI,strength_n_ratio) = max(bootci(length(fisher{clustering}{centralityI,strength_n_ratio}),@mean,fisher{clustering}{centralityI,strength_n_ratio}));
            kendall_mean{clustering}(centralityI,strength_n_ratio) = tanh(fisher_mean{clustering}(centralityI,strength_n_ratio));
            kendall_ci_min{clustering}(centralityI,strength_n_ratio) = tanh(fisher_ci_min{clustering}(centralityI,strength_n_ratio));
            kendall_ci_max{clustering}(centralityI,strength_n_ratio) = tanh(fisher_ci_max{clustering}(centralityI,strength_n_ratio));
            kendall_ci_min_relative{clustering}(centralityI,strength_n_ratio) = kendall_mean{clustering}(centralityI,strength_n_ratio) - kendall_ci_min{clustering}(centralityI,strength_n_ratio);
            kendall_ci_max_relative{clustering}(centralityI,strength_n_ratio) = kendall_ci_max{clustering}(centralityI,strength_n_ratio) - kendall_mean{clustering}(centralityI,strength_n_ratio);
        end
    end
end

%% TAKE OFF TP
if take_off_TP == 1 
    for clustering = 1:length(clustering_methods)
        kendall_mean{clustering} = kendall_mean{clustering}(1:end-1,:);
        kendall_ci_max{clustering} = kendall_ci_max{clustering}(1:end-1,:);
        kendall_ci_min{clustering} = kendall_ci_min{clustering}(1:end-1,:);
        kendall_ci_max_relative{clustering} = kendall_ci_max_relative{clustering}(1:end-1,:);
        kendall_ci_min_relative{clustering} = kendall_ci_min_relative{clustering}(1:end-1,:);
    end
end