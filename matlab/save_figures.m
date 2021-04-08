figure('WindowState','fullscreen')
%% FIGURES & CAPTIONS

histogram(nonzeros(food_web_sizes))
xlabel('Number of nodes')
ylabel('Number of food webs')
ylim([0 8]) 
ax = gca;
ax.FontSize = 30;
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/food_web_sizes.png")
caption = "Size of the food webs we used in our study."
writematrix(caption,"/Users/ema/github/data_aggregation/latex/captions/caption_food_web_sizes.txt")

titles = ["(a)", "(b)", "(c)", "(d)", "(e)", "(f)"];
cluster_plot_size = 25;
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
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/cluster_sizes.png")
writematrix(caption,"/Users/ema/github/data_aggregation/latex/captions/caption_cluster_sizes.txt",'QuoteStrings',false)
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

tiledlayout(1,1)
heatmap(aggregation_methods,centralities_latex,all_mean_kendalls,'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',15)
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/mean_kendalls_a.png") 
heatmap(centralities_latex,aggregation_methods,all_mean_kendalls','ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',7)
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/mean_kendalls_b.png") 
caption1 = "Heat map describing the kendall's rank correlation (τ) between the ranking of the nodes in the original food web and in the aggregated food web. On the x axis, there is the aggregation method, which is described by three components. The first component is the clustering algorithm. The second one is the linkage method. The third one is the method by which we determined the interaction strength. On the y axis, there are the centrality indices.";
caption2 = "Jaccard = Hierachical clustering using Jaccard index, REGE = Hierarchical clustering using REGE index, density = clustering of density-based modules, prey = clustering of prey-based modules, predator = clustering of predator-based modules, groups = clustering of groups."
caption3 = "NMAX = maximum linkage, 25% = at least 25% of links realised to consider a connection, 50% = at least 25% of links realised to consider a connection, 75% = at least 75% of links realised to consider a connection, NMIN = 100% all possible links realised."
caption4 = "min = minimum interaction strength, max = maximum interaction strength, sum = sum of interaction strength, mean = mean interaction strength."
caption5 = "DC = degree centrality, WDC = weighted degree centrality, CC = closeness centrality, BC = betweenness centrality, s = status index, cs = constrostatus index, ns = net status index, kindex = keystone index, kbu = bottom-up keystone index, ktd = top-down keystone index, kdir = directed keystone index, kindir = indirected keystone index, TI1 = 1-step topological imoprtance, TI3 = 3-step topological importance, TI5 = 5-step topological importance, WI1 = 1-step weighted topological importance, WI3 = 3-step weighted topological importance, WI5 = 5-step weighted topological importance, STO1 = 1-step species uniqueness, STO3 = 3-step species uniqueness, STO5 = 5-step species uniqueness, wSTO1 = 1-step weighted species uniqueness, wSTO3 = 3-step weighted species uniqueness, wSTO5 = 5-step weighted species uniqueness, TP = trophic position.";
caption = caption1 + caption2 +caption3 + caption4 + caption5;
writematrix(caption,"/Users/ema/github/data_aggregation/latex/captions/caption_mean_kendalls.txt",'QuoteStrings',false);

heatmap(clustering_better_names,centralities_latex,best_kendall,'ColorMap',color_style,'CellLabelFormat', '%.2f','FontSize', 25)
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/best_kendalls.png") 
caption = "Heat map of the best Kendall's rank correlation coefficient for each combination of clustering methods and centrality indices. The best correlation is selected across linkage methods and methods of determining interaction strength.";
writematrix(caption,"/Users/ema/github/data_aggregation/latex/captions/caption_best_kendalls.txt")
