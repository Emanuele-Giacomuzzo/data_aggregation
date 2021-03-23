%% PARAMETERS

clc,clear;
tot_web_nr = 105;
TP_problems = [63 87];
duplicate_webs = [3 19 62 71 85 86 93 94 97 99 100];
less_than_14 = [4 5 10 14 18 29 34 48 52 57 67 76 79 89 90];
NA_webs = [74];
hc_max_inconsistency = 0.01;
TO_min_threshold = 0.01;
TO_max_threshold = 0.1;
TO_learning_rate = 0.01;
publication_size = 50;
visualisation_size = 10;
font_size = visualisation_size;
checking = 0;

%% COMBINATION OF METHODS

clustering_methods = [ "jaccard_similarity" "rege_similarity" "density_modularity" "prey_modularity" "predator_modularity" "group_model"]; 
centralities = [ "DC" ; "WDC" ; "CC" ; "BC" ; "s" ; "cs" ; "ns" ; "kindex" ; "kbu" ; "ktd" ; "kdir" ; "kindir" ; "TI1" ; "TI3" ; "TI5" ; "WI1" ; "WI3" ; "WI5" ; "STO1" ; "STO3" ; "STO5" ; "wSTO1" ; "wSTO3" ; "wSTO5" ; "TP"]; 
link_methods = [0.001; 0.25 ; 0.5 ; 0.75 ; 1];
strength_methods = ["min" "mean" "max" "sum"];

percentages_better_names = ["1 link" "25% links" "50% links" "75% links" "100% links"];
percentages_and_weights = string.empty;
for ratio= 1:length(link_methods)
    for strength = 1:length(strength_methods)
        percentages_and_weights = [percentages_and_weights; [string(percentages_better_names(ratio)) + " " + strength_methods(strength)]];
    end
end

%% IMPORT

cd '/Users/ema/github/data_aggregation/data/ecobase/adjacency_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    A_ecobase{(file - hidden_files),1} = readmatrix(files(file).name);
end

for clust = 1:length(clustering_methods)
    cd ('/Users/ema/github/data_aggregation/results/membership_' + clustering_methods(clust))
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        membership{(file - hidden_files),clust} = readmatrix(files(file).name);
    end
end

cd '/Users/ema/github/data_aggregation/results/REGE_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    REGE_matrices{(file - hidden_files),1} = readmatrix(files(file).name);
end

%% MAIN
cd '/Users/ema/github/data_aggregation/matlab';
for web = 1:tot_web_nr
    if length(A_ecobase{web}) > 1
        
        A = A_ecobase{web}; 
        A_DAG = createDAG(A, calculateTP(A));
        
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
        centralities_before = double.empty;
        for i = 1:length(centralities); 
            centralities_before = [centralities_before eval(centralities(i))];
        end
        
        realised_link_ratio = cell(length(clustering_methods),1);
        for clust = 1:length(clustering_methods)
            cluster_size = findClusterSize(membership{web,clust});
            possible_links = findPossibleLinks(cluster_size);
            realised_links = findRealisedLinks(A,membership{web,clust});
            realised_link_ratio{clust} = findRealisedLinkRatio(possible_links, realised_links);
        end
        
        %Kendalls = cell(length(clustering_methods),1);
        %A_aggregated = cell(length(clustering_methods),1);
        %for clust = 1:length(clustering_methods); 
        %    Kendalls{clust} = zeros(length(centralities),(length(link_methods)*length(strength_methods))); 
        %    A_aggregated{clust} = cell(length(centralities),(length(link_methods)*length(strength_methods)));
        %end

        for clust = 1:length(clustering_methods)
            for centr = 1:length(centralities)
                column = 0;
                for ratio = 1:length(link_methods)
                    for strength = 1:length(strength_methods)
                        column = column + 1;
                        A_aggregated_weighted = buildWeightedNetwork(A, membership{web,clust}, strength_methods(strength));
                        A_aggregated_binary = buildBinaryNetwork(realised_link_ratio{clust}, link_methods(ratio));
                        A_aggregated{web}{clust}{centr,column} = A_aggregated_weighted .* A_aggregated_binary;
                        centrality_clusters = calculateClusterCentrality(A_aggregated{web}{clust}{centr,column}, centralities(centr));
                        centrality_nodes = assignNodeCentrality(centrality_clusters, membership{web,clust});
                        Kendalls{web}{clust}(centr, column) = calculateKendall([centralities_before(:,centr) centrality_nodes']);
                   end
                end
            end
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clust) + '/' + "Kendalls_" + clustering_methods(clust) + addFrontZeros(web) + ".txt";
            writematrix(Kendalls{web}{clust}, path);
        end
        
    else
        
        for clust = 1:length(clustering_methods)
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clust) + '/' + "Kendalls_" + clustering_methods(clust) + addFrontZeros(web) + ".txt";
            writematrix(A_ecobase{web}, path);
        end
        path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
        
    end
    
    %CHECK EVERYTHING IS FINE FOR A CERTAIN FOOD WEB
    if checking == 1
        deleted_edge_percentage = ((numedges(digraph(A)) - numedges(digraph(A_DAG)))/numedges(digraph(A))) * 100
        for node = 1:length(A)
            xaxis(node) = normrnd(0.5,0.25)
        end
        plot(digraph(A), 'XData', xaxis, 'YData', TP);
        ylabel('Trophic position (TP)','FontSize',20)
        centralities_before_table = array2table(centralities_before,'VariableNames',centralities)
        t = tiledlayout(2,3); 
        for clust = 1:length(clustering_methods)
            nexttile;
            heatmap(realised_link_ratio{clust},'Title',clustering_methods(clust))
        end
        dendrogram(branches_jaccard, 'Orientation', 'left')
        dendrogram(branches_rege,'Orientation', 'left')
        t = tiledlayout(2,3);
        for clust = 1:length(clustering_methods)
            name = "Kendalls_" + clustering_methods(clust) + addFrontZeros(web) + ".txt";
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clust) + '/' + name;
            kendall_matrix = readmatrix(path);
            nexttile;
            heatmap(percentages_and_weights, centralities, kendall_matrix, 'Title',clustering_methods(clust),'ColorMap',parula,'ColorLimits',[0 1])
        end
    end
    
end

%% FIND FOOD WEB SIZES & CLUSTER SIZES

food_web_sizes = double.empty;
for web = 1:tot_web_nr
    food_web_sizes = [food_web_sizes; length(A_ecobase{web})];
end
food_web_sizes(food_web_sizes==1) = [];

cluster_sizes = zeros(web,length(clustering_methods));
for web = 1:tot_web_nr
    for clust = 1:length(clustering_methods)
        cluster_sizes(web,clust) = max(membership{web,clust}) / length(A_ecobase{web});
    end
end
cluster_sizes = rmmissing(cluster_sizes);

%% IMPORT KENDALLS

for clust = 1:length(clustering_methods)
    cd ('/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clust));
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        kendalls{(file - hidden_files),clust} = readmatrix(files(file).name);
    end
end

for clust = 1:length(clustering_methods)
    for web = 1:tot_web_nr
        if sum(sum(isnan(kendalls{web,clust}))) > 0 || sum(sum(isinf(kendalls{web,clust}))) > 0
            if length(A_ecobase{web}) > 1
                "Nan/Inf in clustering " + clust + " in food web " + web
            end
        end
        if sum(find(kendalls{web,clust}==1)) > 0
            "τ = 1 in kendalls{" + web + "," + clust + "} transformed into τ = 0.9999." 
        end
        kendalls{web,clust}(kendalls{web,clust}==1) = 0.9999;
    end
end

%% BAD PREDATOR WEBS

bad_predator_webs = double.empty;
for web = 1:tot_web_nr
    if max(membership{web,5}) == length(A_ecobase{web})
        "The number of clusters created by the group model in food web nr " + web + " is the same as the number of nodes"
        bad_predator_webs = [bad_predator_webs; web];
    end
end

for web = 1:length(bad_predator_webs)
    kendalls{bad_predator_webs(web),5} = NaN
end

%% REARRANGE KENDALLS

kendalls_rearranged = cell(length(clustering_methods),1);
for clust = 1:length(clustering_methods)
    kendalls_rearranged{clust} = cell(length(centralities),length(percentages_and_weights));
end
for clust = 1:length(clustering_methods)
    for cent = 1:length(centralities)
        for strength_n_ratio = 1:length(percentages_and_weights)
            for web = 1:tot_web_nr
                if length(kendalls{web,clust}) > 1
                    kendalls_rearranged{clust}{cent,strength_n_ratio} = [kendalls_rearranged{clust}{cent,strength_n_ratio}; kendalls{web,clust}(cent,strength_n_ratio)];
                end
            end
        end
    end
end

%% CALCULATE MEAN AND CI 

for clust = 1:length(clustering_methods)
    for cent = 1:length(centralities)
        for strength_n_ratio = 1:length(percentages_and_weights)
            fisher{clust}{cent,strength_n_ratio} = atanh(kendalls_rearranged{clust}{cent,strength_n_ratio});
            fisher_mean{clust}(cent,strength_n_ratio) = mean(fisher{clust}{cent,strength_n_ratio});
            fisher_ci_min{clust}(cent,strength_n_ratio) = min(bootci(length(fisher{clust}{cent,strength_n_ratio}),@mean,fisher{clust}{cent,strength_n_ratio}));
            fisher_ci_max{clust}(cent,strength_n_ratio) = max(bootci(length(fisher{clust}{cent,strength_n_ratio}),@mean,fisher{clust}{cent,strength_n_ratio}));
            kendall_mean{clust}(cent,strength_n_ratio) = tanh(fisher_mean{clust}(cent,strength_n_ratio));
            kendall_ci_min{clust}(cent,strength_n_ratio) = tanh(fisher_ci_min{clust}(cent,strength_n_ratio));
            kendall_ci_max{clust}(cent,strength_n_ratio) = tanh(fisher_ci_max{clust}(cent,strength_n_ratio));
            kendall_ci_min_relative{clust}(cent,strength_n_ratio) = kendall_mean{clust}(cent,strength_n_ratio) - kendall_ci_min{clust}(cent,strength_n_ratio);
            kendall_ci_max_relative{clust}(cent,strength_n_ratio) = kendall_ci_max{clust}(cent,strength_n_ratio) - kendall_mean{clust}(cent,strength_n_ratio);
        end
    end
end

%% PLOT

histogram(nonzeros(food_web_sizes))
title("Food web sizes. Median = " + median(food_web_sizes) + " (IQR=" + iqr(food_web_sizes) + ").")
xlabel('Number of nodes in the food web')
ylabel('Food web n')
ax = gca;
ax.FontSize = font_size;
saveas(gcf,'/Users/ema/github/data_aggregation/pics/food_web_sizes.png') 

t = tiledlayout(2,3); edges = [0:0.1:1];
for clust = 1:length(clustering_methods)
    nexttile;
    histogram(cluster_sizes(:,clust),edges);
    title(strrep(clustering_methods(clust),"_"," ") + " x=" + round(median(cluster_sizes(:,clust)),2) + " IQR=" + round(iqr(cluster_sizes(:,clust)),2),'FontSize',font_size);
    xlabel('Size aggregated web/ size original web','FontSize',font_size);
    ylabel('Number of food webs with this size','FontSize',font_size);
    ax = gca; 
    ax.FontSize = font_size;
end
saveas(gcf,'/Users/ema/github/data_aggregation/pics/cluster_sizes.png') 

font_size = 15
heatmap(percentages_and_weights,centralities,kendall_mean{1},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using Jaccard: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_jaccard.png') 
heatmap(percentages_and_weights,centralities,kendall_mean{2},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using REGE: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_rege.png') 
heatmap(percentages_and_weights,centralities,kendall_mean{3},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using density-based modules: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_density.png') 
heatmap(percentages_and_weights,centralities,kendall_mean{4},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using prey-based modules: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_prey.png') 
heatmap(percentages_and_weights,centralities,kendall_mean{5},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using predator-based modules: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_predator.png') 
heatmap(percentages_and_weights,centralities,kendall_mean{6},'ColorMap',parula,'ColorLimits',[0 1],'CellLabelFormat', '%.2f','title','Aggregation using the group model: mean correlation between the ranking before the aggregation and after the aggregation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_mean_groups.png') 

heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{1},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using Jaccard: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_jaccard.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{2},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using REGE: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_rege.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{3},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using density-based modules: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_density.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{4},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using prey-based modules: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_prey.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{5},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using predator-based modules: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_predator.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_min_relative{6},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using the groups model: lower confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_min_groups.png') 

heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{1},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using Jaccard: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_jaccard.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{2},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using REGE: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_rege.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{3},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using density-based modules: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_density.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{4},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using prey-based modules: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_prey.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{5},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using predator-based modules: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_predator.png') 
heatmap(percentages_and_weights,centralities,kendall_ci_max_relative{6},'ColorMap',parula,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f','title','Aggregation using the group model: upper confidence interval of the mean correlation.', 'FontSize',font_size)
saveas(gcf,'/Users/ema/github/data_aggregation/pics/kendall_ci_max_groups.png')