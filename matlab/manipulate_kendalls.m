%% IMPORT, MODIFY AND REARRANGE KENDALLS
for clustering = 1:length(clustering_methods)
    cd ('/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering));
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        kendalls{(file - hidden_files),clustering} = readmatrix(files(file).name);
    end
end

for clustering = 1:length(clustering_methods)
    for web = 1:tot_web_nr
        if length(A_ecobase{web}) > 1
            if sum(sum(isnan(kendalls{web,clustering}))) > 0 || sum(sum(isinf(kendalls{web,clustering}))) > 0
                "Nan/Inf in clustering " + clustering + " in food web " + web
            end
        end
        if sum(find(kendalls{web,clustering}==1)) > 0
            kendalls{web,clustering}(kendalls{web,clustering}==1) = 0.99;
            "τ = 1 in kendalls{" + web + "," + clustering + "} transformed into τ = 0.99."
        end
    end
end

for bad_clustering = 1:length(row)
    kendalls{row(bad_clustering),col(bad_clustering)} = NaN;
end

kendalls_rearranged = cell(length(clustering_methods),1);
for clustering = 1:length(clustering_methods)
    kendalls_rearranged{clustering} = cell(length(centralities),length(linkage_n_strength));
end

for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(centralities)
        for strength_n_ratio = 1:length(linkage_n_strength)
            for web = 1:tot_web_nr
                if length(kendalls{web,clustering}) > 1
                    kendalls_rearranged{clustering}{centralityI,strength_n_ratio} = [kendalls_rearranged{clustering}{centralityI,strength_n_ratio}; kendalls{web,clustering}(centralityI,strength_n_ratio)];
                end
            end
        end
    end
end

%% CALCULATE MEAN AND CI 
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

all_mean_kendalls = double.empty;
for clustering = 1:length(clustering_methods)
    all_mean_kendalls = [all_mean_kendalls kendall_mean{clustering}];
end

all_max_ci = double.empty;
for clustering = 1:length(clustering_methods)
    all_max_ci = [all_max_ci kendall_ci_max{clustering}];
end
all_max_ci = all_max_ci - all_mean_kendalls;

all_min_ci = double.empty;
for clustering = 1:length(clustering_methods)
    all_min_ci = [all_min_ci kendall_ci_min{clustering}];
end
all_min_ci = all_mean_kendalls - all_min_ci;

%% FIND BEST AGGREGATION
best_kendall = zeros(length(centralities),length(clustering_methods));
best_link_n_strength = zeros(length(centralities),length(clustering_methods));
ci_min_of_best = zeros(length(centralities),length(clustering_methods));
ci_max_of_best = zeros(length(centralities),length(clustering_methods));
for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(centralities)
        [best_kendall(centralityI,clustering), best_link_n_strength(centralityI,clustering)] = max(kendall_mean{clustering}(centralityI,:));
        ci_min_of_best(centralityI,clustering) = kendall_ci_min{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
        ci_max_of_best(centralityI,clustering) = kendall_ci_max{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
    end
end
ci_min_of_best = round(ci_min_of_best,2);
ci_max_of_best = round(ci_max_of_best,2);

rankings = strings(length(centralities),length(clustering_methods));
rankings_ci = strings(length(centralities),length(clustering_methods));
rankings_link_n_strength = strings(length(centralities),length(clustering_methods));
for centralityI = 1:length(centralities)
    [sorted_values, sorted_values_indices] = sort(best_kendall(centralityI,:),'descend');
    sorted_values = round(sorted_values,2);
    for rank = 1:length(clustering_methods)
        rankings(centralityI,rank) = "A" + sorted_values_indices(rank) + " (" + sorted_values(rank) + ")";
        rankings_ci(centralityI,rank) = ci_min_of_best(centralityI,sorted_values_indices(rank)) + "-" + ci_max_of_best(centralityI,sorted_values_indices(rank));
        rankings_link_n_strength(centralityI,rank) = "M" + best_link_n_strength(centralityI,sorted_values_indices(rank)) + " ";
    end
end

for clustering = 1:length(clustering_methods)
    rankings = strrep(rankings, "A"+clustering, clustering_better_names(clustering));
end

for method = 1:length(linkage_n_strength)
    rankings_link_n_strength = strrep(rankings_link_n_strength, "M"+method+" ", linkage_n_strength(method));
end

%If the centralityI index is not a weighted one, delete the strength part.
for centralityI = 1:length(centralities)
    if isempty(find(weighted_centralities==centralityI)) == 1;
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"min","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"max","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"sum","");
        rankings_link_n_strength(centralityI,:) = strrep(rankings_link_n_strength(centralityI,:),"mean","");
    end
end

rank_table = array2table(rankings,'VariableNames',["First" "Second" "Third" "Fourth" "Fifth" "Sixth"],'RowNames',centralities)
rank_table_ci = array2table(rankings_ci,'VariableNames',["First" "Second" "Third" "Fourth" "Fifth" "Sixth"],'RowNames',centralities)
rank_table_aggregations = array2table(rankings_link_n_strength,'VariableNames',["First" "Second" "Third" "Fourth" "Fifth" "Sixth"],'RowNames',centralities)

cd '/Users/ema/github/data_aggregation/matlab';
