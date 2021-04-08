%% SUPPORTING INFORMATION
figure_nr = 0;

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{1},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{2},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{3},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{4},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{5},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{6},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
caption = "Sections of Figure 3, which allows to read the single values. Figure S1= Jaccard, Figure S2= REGE, Figure S3= Density-based modules, Figure S4= Prey-based modules, Figure S5= Predator-based modules, Figure S6= Group model.";
writematrix(caption, "/Users/ema/github/data_aggregation/supporting_information/Caption_figure_S" + (figure_nr-5) + "-S" + figure_nr + ".txt")

figure_nr = figure_nr + 1;
heatmap(aggregation_methods, centralities_latex, all_max_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
writematrix(caption,"/Users/ema/github/data_aggregation/figures/Caption_figure_S" + figure_nr + ".txt")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_max_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png");
caption = "Heat maps of the upper confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its upper confidence interval. Figure 7: upper CI for all the clustering methods, figure8: upper CI for Jaccard index, figure9: upper Ci for REGE index, figure10: upper CI for density-based modules, figure_nr 11: upper CI for prey-based modules, figure_nr 12: upper CI for predator-based modules, figure13: upper CI for group model";
writematrix(caption,"/Users/ema/github/data_aggregation/supporting_information/Caption_figure_S" + (figure_nr-6) + "-S" + figure_nr + ".txt")

figure_nr = figure_nr + 1;
heatmap(aggregation_methods, centralities_latex, all_min_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
writematrix(caption,'/Users/ema/github/data_aggregation/supporting_information/min_ci_all.txt')
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_ci_min_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"/Users/ema/github/data_aggregation/supporting_information/Figure_S" + figure_nr + ".png")
caption = "Heat maps of the lower confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its lower confidence interval. Figure 14: upper CI for all the clustering methods, figure15: upper CI for Jaccard index, figure16: upper Ci for REGE index, figure17: upper CI for density-based modules, figure_nr 18: upper CI for prey-based modules, figure_nr 19: upper CI for predator-based modules, figure20: upper CI for group model";
writematrix(caption,"/Users/ema/github/data_aggregation/supporting_information/Caption_figure_S" + (figure_nr-6) + "-S" + figure_nr + ".txt")

%writetable(rank_table, '/Users/ema/github/data_aggregation/supporting_information/rank_table.txt');
%writetable(rank_table_ci, '/Users/ema/github/data_aggregation/supporting_information/rank_table_ci.txt');
%writetable(rank_table_aggregations, '/Users/ema/github/data_aggregation/supporting_information/rank_table_aggregations.txt');
