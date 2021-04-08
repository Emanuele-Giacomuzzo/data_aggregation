cd '/Users/ema/github/data_aggregation/matlab';
clc,clear;
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

whole_analysis = 1;
take_off_TP = 1;

color_style = jet;
medium_font_size = 18;
small_font_size = 12;

%% PROGRAMM
centralities_n_aggregations;
cd '/Users/ema/github/data_aggregation/matlab';
if whole_analysis == 1
    indices_analysis;
end
save at_the_end_of_whole_analysis
sizes_of_clusters;
manipulate_kendalls;
save_figures;
save_supporting_info;

chosen_web=37;
indices_analysis;
representative_web;

















