%% FOOD WEBS
cd '/Users/ema/github/data_aggregation/data/adjacency_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    A_ecobase{(file - hidden_files)} = readmatrix(files(file).name);
end

food_web_sizes = double.empty;
for web = 1:tot_web_nr
    food_web_sizes = [food_web_sizes; length(A_ecobase{web})];
end
food_web_sizes(food_web_sizes==1) = [];
%% CENTRALITIES
centralities = [ "DC" ; "WDC" ; "CC" ; "BC" ; "s" ; "cs" ; "ns" ; "kindex" ; "kbu" ; "ktd" ; "kdir" ; "kindir" ; "TI1" ; "TI3" ; "TI5" ; "WI1" ; "WI3" ; "WI5" ; "STO1" ; "STO3" ; "STO5" ; "wSTO1" ; "wSTO3" ; "wSTO5"; "TP"]; 
centralities_latex = [ "DC" ; "WDC" ; "CC" ; "BC" ; "s" ; "s'" ; "\Delta s" ; "k" ; "k_{bu}" ; "k_{td}" ; "k_{dir}" ; "k_{indir}" ; "TI^1" ; "TI^3" ; "TI^5" ; "WI^1" ; "WI^3" ; "WI^5" ; "STO^1" ; "STO^3" ; "STO^5" ; "wSTO^1" ; "wSTO^3" ; "wSTO^5"; "TP"]; ;
weighted_centralities = [2,16,17,18,22,23,24];

%% CLUSTERING METHODS 
clustering_methods = [ "jaccard_similarity" "rege_similarity" "density_modularity" "prey_modularity" "predator_modularity" "group_model"]; 
clustering_better_names = ["Jaccard" "REGE" "density" "prey" "predator" "groups"];

for clustering = 1:length(clustering_methods)
    cd ('/Users/ema/github/data_aggregation/results/membership_' + clustering_methods(clustering))
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        membership{(file - hidden_files),clustering} = readmatrix(files(file).name);
    end
end

cd '/Users/ema/github/data_aggregation/results/REGE_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    REGE_matrices{(file - hidden_files),1} = readmatrix(files(file).name);
end
%% LINKAGE METHODS AND STRENGTH METHODS 
linkage_methods = [0.001; 0.25 ; 0.5 ; 0.75 ; 1];
linkage_methods_names = ["NMAX" "25%" "50%" "75%" "NMIN"];
strength_methods = ["min" "mean" "max" "sum"];

linkage_n_strength = string.empty;
for linkage = 1:length(linkage_methods)
    for strength = 1:length(strength_methods)
        linkage_n_strength = [linkage_n_strength; [string(linkage_methods_names(linkage)) + " " + strength_methods(strength)]];
    end
end
%% AGGREGATION METHODS 
aggregation_methods = string.empty;
for clustering = 1:length(clustering_methods)
    for links = 1:length(linkage_n_strength)
       aggregation_methods = [aggregation_methods; (clustering_better_names(clustering) + " " + linkage_n_strength(links))];
    end
end