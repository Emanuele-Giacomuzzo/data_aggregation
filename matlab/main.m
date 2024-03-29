%1. Compute the REGE matrices in UCINET
%2. Compute the groups by using the model of Allesina & Sander in C
%3. Compute the modularity maximisation in R (main 1)
%4. Run the following program
cd '/Users/ema/github/data_aggregation/matlab';
clc,clear;
figure('WindowState','fullscreen')

%% PARAMETERS

%ANALYSIS
whole_analysis = 0;
take_off_TP = 1;

%FOOD WEBS
tot_web_nr = 105;
TP_problems = [63 87];
duplicate_webs = [3 19 62 71 85 86 93 94 97 99 100];
less_than_14_nodes = [4 5 10 14 18 29 34 48 52 57 67 76 79 89 90];
NA_webs = [74];
webs_used = setdiff(1:tot_web_nr,[TP_problems duplicate_webs less_than_14_nodes NA_webs]);
chosen_importance = 2;
chosen_web = 37;

%VALUES
hc_max_inconsistency = 0.01;
TO_min_threshold = 0.01;
TO_max_threshold = 0.1;
TO_learning_rate = 0.01;

%VISUALISATION
color_style = jet;
medium_font_size = 18;
small_font_size = 12;

%% ANALYSIS
define_centralities;
define_aggregations;

import_adjacency_matrices;
import_memberships;
import_rege_matrices;

if whole_analysis == 1 
    for web = 1:tot_web_nr
        if length(A_ecobase{web}) > 1
            A = A_ecobase{web};
            find_membership_of_Jaccard;
            find_membership_of_REGE;
            calculate_original_centralities;
            calculate_realised_link_ratios;
            calculate_n_save_kendalls;
        else
            save_empty_kendalls_n_memberships;
        end
    end
end

%% POST ANALYSIS
calculate_food_web_sizes;
save_food_web_sizes_figure;
calculate_cluster_sizes;
save_cluster_sizes_figure;

import_kendalls;
screen_kendalls;
get_rid_of_bad_clusterings;
rearrange_kendalls;

calculate_mean_and_ci;
rearrange_mean_and_ci;
save_mean_heatmap;
figure_nr = 1;
save_ci_heatmaps;
save_mean_heatmap_by_clustering;
save_ci_heatmap_by_clustering;

find_best_aggregations;
save_best_aggregations_heatmap;
rank_best_aggregations;
save_ranking_table;
writematrix(centralities_figures, "../results/tables/centralities.txt");
save_supporting_tables;

%% REPRESENTATIVE WEB
web = chosen_web;
A = A_ecobase{web};
find_membership_of_Jaccard;
find_membership_of_REGE;
calculate_original_centralities;
calculate_realised_link_ratios;
calculate_n_save_kendalls;

compute_importance_before;
compute_original_coordinates;

for clustering = 1:length(clustering_methods)
    
    find_best_linkage_n_strength;
    A_clusters = A_aggregated{chosen_web}{clustering,best_strength_n_links};
    compute_importance_after_clustering;
    node_colors = assignNodeColors(importance_before, importance_after_nodes);
    cluster_colors = assignClusterColors(membership{chosen_web,clustering});
    size_of_clusters = findClusterSize(membership{chosen_web,clustering});
    
    TP_clusters = calculateTP(A_clusters);
    calculate_TP_from_DAG;
    
    compute_clustered_web_coordinates;
    save_matrices_to_plot_clustered_food_web;
    
end

%5. Produce the food web figures and the colorful table in R (main 2)