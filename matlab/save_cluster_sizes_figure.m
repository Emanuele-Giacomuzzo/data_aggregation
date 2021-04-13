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