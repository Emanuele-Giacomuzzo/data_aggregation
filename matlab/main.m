cd '/Users/ema/github/data_aggregation/matlab';
clc,clear;
figure('WindowState','fullscreen')
%% PARAMETERS
tot_web_nr = 105;
TP_problems = [63 87];
duplicate_webs = [3 19 62 71 85 86 93 94 97 99 100];
less_than_14_nodes = [4 5 10 14 18 29 34 48 52 57 67 76 79 89 90];
NA_webs = [74];
webs_used = setdiff(1:tot_web_nr,[TP_problems duplicate_webs less_than_14_nodes NA_webs]);
chosen_importance = 2;

hc_max_inconsistency = 0.01;
TO_min_threshold = 0.01;
TO_max_threshold = 0.1;
TO_learning_rate = 0.01;

whole_analysis = 0;
take_off_TP = 1;

color_style = jet;
medium_font_size = 18;
small_font_size = 12;

%% ANALYSIS
import_adjacency_matrices;
calculate_food_web_sizes;
define_centralities;
define_aggregations;
import_memberships;
import_rege_matrices;

if whole_analysis == 1
    indices_analysis;
end

%% POST ANALYSIS
calculate_cluster_sizes;

import_kendalls;
screen_kendall_values;
rearrange_kendalls;

calculate_mean_n_ci_of_kendalls;
compute_comprehensive_heatmaps;
save_comprehensive_heatmap_mean;
save_comprehensive_heatmaps_ci;

save_kendall_mean_for_each_clustering;
save_kendall_ci_for_each_clustering;

find_best_aggregations;
rank_best_aggregations;
take_off_TP;

write_ranking_table;
write_supporting_tables;

chosen_web=37;
indices_analysis;
representative_web;

















