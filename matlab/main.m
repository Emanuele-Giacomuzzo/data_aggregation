clc,clear;
%% PARAMETERS
tot_web_nr = 105;
TP_problems = [63 87];
duplicate_webs = [3 19 62 71 85 86 93 94 97 99 100];
less_than_14_nodes = [4 5 10 14 18 29 34 48 52 57 67 76 79 89 90];
NA_webs = [74];
webs_used = setdiff(1:tot_web_nr,[TP_problems duplicate_webs less_than_14_nodes NA_webs]);
chosen_web=37;

hc_max_inconsistency = 0.01;
TO_min_threshold = 0.01;
TO_max_threshold = 0.1;
TO_learning_rate = 0.01;

take_off_TP = 1;

color_style = jet;
medium_font_size = 18;
small_font_size = 12;
%% FOOD WEBS
cd '/Users/ema/github/data_aggregation/data/ecobase/adjacency_matrices'
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
centralities = [ "DC" ; "WDC" ; "CC" ; "BC" ; "s" ; "cs" ; "ns" ; "kindex" ; "kbu" ; "ktd" ; "kdir" ; "kindir" ; "TI1" ; "TI3" ; "TI5" ; "WI1" ; "WI3" ; "WI5" ; "STO1" ; "STO3" ; "STO5" ; "wSTO1" ; "wSTO3" ; "wSTO5" ; "TP"]; 
centralities_latex = [ "DC" ; "WDC" ; "CC" ; "BC" ; "s" ; "s'" ; "\Delta s" ; "k" ; "k_{bu}" ; "k_{td}" ; "k_{dir}" ; "k_{indir}" ; "TI^1" ; "TI^3" ; "TI^5" ; "WI^1" ; "WI^3" ; "WI^5" ; "STO^1" ; "STO^3" ; "STO^5" ; "wSTO^1" ; "wSTO^3" ; "wSTO^5" ; "TP"]; ;
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
%% MAIN
cd '/Users/ema/github/data_aggregation/matlab';
for web = chosen_web %1:tot_web_nr %chosen_web
    if length(A_ecobase{web}) > 1
        
        A = A_ecobase{web};
        A_DAG = createDAG(A);
        
        branches_jaccard = findBranches(A,"jaccard");
        membership{web,1} = cluster(branches_jaccard,'cutoff',hc_max_inconsistency);
        path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt';
        writematrix(membership{web,1}, path);
        branches_rege = findBranches(A,"rege",REGE_matrices{web});
        membership{web,2} = cluster(branches_rege,'cutoff',hc_max_inconsistency); 
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt';
        writematrix(membership{web,2}, path);
        
        DC = centrality(graph(toundirected(A)),'degree');
        WDC = calculateWDC(A);
        CC = centrality(graph(toundirected(A)),'closeness');
        BC = centrality(digraph(A),'betweenness');
        [s,cs,ns] = calculateStatus(A_DAG);
        [kindex,kbu,ktd,kdir,kindir] = calculateKeystone(A_DAG);
        TI1 = calculateTI(A,1,"false");
        TI3 = calculateTI(A,3,"false");
        TI5 = calculateTI(A,5,"false");
        WI1 = calculateTI(A,1,"true");
        WI3 = calculateTI(A,3,"true");
        WI5 = calculateTI(A,5,"true");
        STO1 = calculateSTO(A, 1, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
        STO3 = calculateSTO(A, 3, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
        STO5 = calculateSTO(A, 5, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
        wSTO1 = calculateSTO(A, 1, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
        wSTO3 = calculateSTO(A, 3, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
        wSTO5 = calculateSTO(A, 5, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
        TP = calculateTP(A);
        centralities_original = double.empty;
        for i = 1:length(centralities); 
            centralities_original = [centralities_original eval(centralities(i))];
        end
        
        realised_link_ratio = cell(length(clustering_methods),1);
        for clustering = 1:length(clustering_methods)
            cluster_size = findClusterSize(membership{web,clustering});
            possible_links = findPossibleLinks(cluster_size);
            realised_links = findRealisedLinks(A,membership{web,clustering});
            realised_link_ratio{clustering} = findRealisedLinkRatio(possible_links, realised_links);
        end
        
        for clustering = 1:length(clustering_methods)
            for centr = 1:length(centralities)
                column = 0;
                for linkage = 1:length(linkage_methods)
                    for strength = 1:length(strength_methods)
                        column = column + 1;
                        A_aggregated_weighted = buildWeightedNetwork(A, membership{web,clustering}, strength_methods(strength));
                        A_aggregated_binary = buildBinaryNetwork(realised_link_ratio{clustering}, linkage_methods(linkage));
                        A_aggregated{web}{clustering,column} = A_aggregated_weighted .* A_aggregated_binary;
                        centrality_clusters = calculateClusterCentrality(A_aggregated{web}{clustering,column}, centralities(centr));
                        centrality_nodes = assignNodeCentrality(centrality_clusters, membership{web,clustering});
                        Kendalls{web}{clustering}(centr, column) = calculateKendall([centralities_original(:,centr) centrality_nodes']);
                   end
                end
            end
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
            writematrix(Kendalls{web}{clustering}, path);
        end
        
    else
        
        for clustering = 1:length(clustering_methods)
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
            writematrix(A_ecobase{web}, path);
        end
        path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
        
    end
    
end
%% FIND CLUSTER SIZES
for web = 1:tot_web_nr
    for clustering = 1:length(clustering_methods)
        cluster_sizes(web,clustering) = max(membership{web,clustering}) / length(A_ecobase{web});
    end
end
[row,col] = find(cluster_sizes == 1);
cluster_sizes = rmmissing(cluster_sizes);
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

%% FIGURES & CAPTIONS
figure = 0;

figure = figure + 1;
histogram(nonzeros(food_web_sizes))
xlabel('Number of nodes')
ylabel('Number of food webs')
ylim([0 8]) 
ax = gca;
ax.FontSize = 15;
saveas(gcf,"/Users/ema/github/data_aggregation/paper/figures/Figure_" + figure + ".png")
caption = "Size of the food webs we used in our study."
writematrix(caption,"/Users/ema/github/data_aggregation/paper/figures/Caption_figure_" + figure + ".txt")

figure = figure + 1;
titles = ["(a)", "(b)", "(c)", "(d)", "(e)", "(f)"];
cluster_plot_size = 12;
additional_info = string.empty;
t = tiledlayout(2,3); edges = [0:1:100];
caption = "Size of the clusters produced by the different clustering methods. (a) = hierarchical clustering with Jaccard index, (b) = hierarchical clustering with REGE index, (c) = maximisation of density-based modularity, (d) = maximisation of prey-based modularity, (e) = maximisation of predator-based modularity, (f) = group model.";
for clustering = 1:length(clustering_methods)
    nexttile;
    membership_cluster_sizes = cluster_sizes(:,clustering);
    membership_cluster_sizes(membership_cluster_sizes==1) = [];
    histogram(membership_cluster_sizes*100,edges);
    title(titles(clustering));
    xlabel('Size aggregated web / Size original web (%)','FontSize',cluster_plot_size);
    ylabel('Number of food webs','FontSize',cluster_plot_size);
    ylim([0 12]) 
    ax = gca; 
    ax.FontSize = cluster_plot_size;
    %caption = caption + round(median(cluster_sizes(:,clustering)*100),1) + "% (IQR=" + round(iqr(cluster_sizes(:,clustering)*100),1) + ") for " + clustering_better_names(clustering) + " " + titles(clustering) + ", "
end
saveas(gcf,"/Users/ema/github/data_aggregation/paper/figures/Figure_" + figure + ".png")
writematrix(caption,"/Users/ema/github/data_aggregation/paper/figures/Caption_figure_" + figure + ".txt")
tiledlayout(1,1)

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

figure = figure + 1;
heatmap(aggregation_methods,centralities_latex,all_mean_kendalls,'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',12)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/figures/Figure_" + figure + "a.png") 
heatmap(centralities_latex,aggregation_methods,all_mean_kendalls','ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',7)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/figures/Figure_" + figure + "b.png") 
caption1 = "Heat map describing the kendall's rank correlation (τ) between the ranking of the nodes in the original food web and in the aggregated food web. On the x axis, there is the aggregation method, which is described by three components. The first component is the clustering algorithm. The second one is the linkage method. The third one is the method by which we determined the interaction strength. On the y axis, there are the centrality indices.";
caption2 = "Jaccard = Hierachical clustering using Jaccard index, REGE = Hierarchical clustering using REGE index, density = clustering of density-based modules, prey = clustering of prey-based modules, predator = clustering of predator-based modules, groups = clustering of groups."
caption3 = "NMAX = maximum linkage, 25% = at least 25% of links realised to consider a connection, 50% = at least 25% of links realised to consider a connection, 75% = at least 75% of links realised to consider a connection, NMIN = 100% all possible links realised."
caption4 = "min = minimum interaction strength, max = maximum interaction strength, sum = sum of interaction strength, mean = mean interaction strength."
caption5 = "DC = degree centrality, WDC = weighted degree centrality, CC = closeness centrality, BC = betweenness centrality, s = status index, cs = constrostatus index, ns = net status index, kindex = keystone index, kbu = bottom-up keystone index, ktd = top-down keystone index, kdir = directed keystone index, kindir = indirected keystone index, TI1 = 1-step topological imoprtance, TI3 = 3-step topological importance, TI5 = 5-step topological importance, WI1 = 1-step weighted topological importance, WI3 = 3-step weighted topological importance, WI5 = 5-step weighted topological importance, STO1 = 1-step species uniqueness, STO3 = 3-step species uniqueness, STO5 = 5-step species uniqueness, wSTO1 = 1-step weighted species uniqueness, wSTO3 = 3-step weighted species uniqueness, wSTO5 = 5-step weighted species uniqueness, TP = trophic position";
caption = caption1 + caption2 +caption3 + caption4 + caption5;
writematrix(caption,"/Users/ema/github/data_aggregation/paper/figures/Caption_figure_" + figure + ".txt");

figure = figure + 1;
heatmap(clustering_better_names,centralities_latex,best_kendall,'ColorMap',color_style,'CellLabelFormat', '%.2f','FontSize', 18)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/figures/Figure_" + figure + ".png") 
caption = "Heat map of the best Kendall's rank correlation coefficient for each combination of clustering methods and centrality indices. The best correlation is selected across linkage methods and methods of determining interaction strength.";
writematrix(caption,"/Users/ema/github/data_aggregation/paper/figures/Caption_figure_" + figure + ".txt")

%% SUPPORTING INFORMATION
figure = 0;

figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{1},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{2},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{3},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{4},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{5},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{6},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
caption = "Sections of Figure 3, which allows to read the single values. Figure S1= Jaccard, Figure S2= REGE, Figure S3= Density-based modules, Figure S4= Prey-based modules, Figure S5= Predator-based modules, Figure S6= Group model.";
writematrix(caption, "/Users/ema/github/data_aggregation/paper/supporting_information/Caption_figure_" + (figure-5) + "-" + figure + ".txt")

figure = figure + 1;
heatmap(aggregation_methods, centralities_latex, all_max_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
writematrix(caption,"/Users/ema/github/data_aggregation/paper/figures/Caption_figure_S" + figure + ".txt")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png");
caption = "Heat maps of the upper confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its upper confidence interval. Figure 7: upper CI for all the clustering methods, figure8: upper CI for Jaccard index, figure9: upper Ci for REGE index, figure10: upper CI for density-based modules, figure 11: upper CI for prey-based modules, figure 12: upper CI for predator-based modules, figure13: upper CI for group model";
writematrix(caption,"/Users/ema/github/data_aggregation/paper/supporting_information/Caption_figure_" + (figure-6) + "-" + figure + ".txt")

figure = figure + 1;
heatmap(aggregation_methods, centralities_latex, all_min_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
writematrix(caption,'/Users/ema/github/data_aggregation/paper/supporting_information/min_ci_all.txt')
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
figure = figure + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/paper/supporting_information/Figure_S" + figure + ".png")
caption = "Heat maps of the lower confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its lower confidence interval. Figure 14: upper CI for all the clustering methods, figure15: upper CI for Jaccard index, figure16: upper Ci for REGE index, figure17: upper CI for density-based modules, figure 18: upper CI for prey-based modules, figure 19: upper CI for predator-based modules, figure20: upper CI for group model";
writematrix(caption,"/Users/ema/github/data_aggregation/paper/supporting_information/Caption_figure_S" + (figure-6) + "-" + figure + ".txt")

%writetable(rank_table, '/Users/ema/github/data_aggregation/paper/supporting_information/rank_table.txt');
%writetable(rank_table_ci, '/Users/ema/github/data_aggregation/paper/supporting_information/rank_table_ci.txt');
%writetable(rank_table_aggregations, '/Users/ema/github/data_aggregation/paper/supporting_information/rank_table_aggregations.txt');

%% BUILD THE REPRESENTATIVE FOOD WEB
cd '/Users/ema/github/data_aggregation/matlab'

selected_centrality = 2;
WDC_original = calculateWDC(A_ecobase{chosen_web});
centrality_original = repmat("not central", length(WDC_original),1);
[~,keystone] = max(WDC_original);
centrality_original(keystone) = "central";
coordinates_original = zeros(length(A_ecobase{chosen_web}),2);
for node = 1:length(coordinates_original)
    coordinates_original(node,1) = normrnd(0.5,0.25);
    coordinates_original(node,2) = TP(node);
end
file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_original_web_" + web + ".csv";
writematrix(coordinates_original, file);

for clustering = 1:length(clustering_methods)
    
    [~,best_strength_n_links] = max(kendalls{chosen_web,clustering}(selected_centrality,:));
    if clustering == 3; best_strength_n_links = 2; end
    A_clusters = A_aggregated{chosen_web}{clustering,best_strength_n_links};
    
    WDC_clusters_after = calculateWDC(A_clusters);
    centrality_clusters_after = repmat("not central", length(A_clusters),1);
    [~,keystone] = max(WDC_clusters_after);
    centrality_clusters_after(keystone) = "central";
    centrality_nodes_after = (assignNodeCentrality(centrality_clusters_after, membership{chosen_web,clustering}))';
    
    node_colors = assignNodeColors(centrality_original, centrality_nodes_after);
    cluster_colors = assignClusterColors(membership{chosen_web,clustering});
    size_of_clusters = findClusterSize(membership{chosen_web,clustering});
    
    TP_clusters = calculateTP(A_clusters);
    nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
    if nan_inf ~= 0
        A_clusters_DAG = createDAG(A_clusters);
        TP_clusters = calculateTP(A_clusters_DAG);
        nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
        if nan_inf ~= 0
            "Still a problem with TP"
        end
    end
    
    coordinates_clusters = double.empty;
    nodes_of_clusters = cell(length(A_clusters),2);
    for cluster = 1:length(A_clusters)
        nodes_of_clusters{cluster,1} = find(membership{chosen_web,clustering}==cluster);
        for node = 1:length(nodes_of_clusters{cluster})
            nodes_of_clusters{cluster,2} = [nodes_of_clusters{cluster,2}; coordinates_original(nodes_of_clusters{cluster,1}(node),1)];
        end
        nodes_of_clusters{cluster,2} = mean(nodes_of_clusters{cluster,2});
        coordinates_clusters(cluster) = nodes_of_clusters{cluster,2};
    end
    coordinates_clusters = [coordinates_clusters' TP_clusters];
    
    file = "/Users/ema/github/data_aggregation/r/plotting/A_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(A_clusters,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(coordinates_clusters,file);    
    file = "/Users/ema/github/data_aggregation/r/plotting/colors_original_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(node_colors,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/colors_clustered_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(cluster_colors,file);
    file = "/Users/ema/github/data_aggregation/r/plotting/cluster_sizes_" + clustering_better_names(clustering) + "_web_" + chosen_web + ".csv";
    writematrix(size_of_clusters,file);
    
end




































