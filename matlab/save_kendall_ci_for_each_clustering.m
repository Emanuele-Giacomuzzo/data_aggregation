%% FIGURES OF CI MAX
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

%% CAPTION OF CI MAX
caption = "Heat maps of the upper confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its upper confidence interval. Figure 7: upper CI for all the clustering methods, figure8: upper CI for Jaccard index, figure9: upper Ci for REGE index, figure10: upper CI for density-based modules, figure_nr 11: upper CI for prey-based modules, figure_nr 12: upper CI for predator-based modules, figure13: upper CI for group model";
writematrix(caption,"../supporting_information/Caption_figure_S" + (figure_nr-6) + "-S" + figure_nr + ".txt")


%% FIGURS OF CI MIN 
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")

%% CAPTION OF CI MIN 
caption = "Heat maps of the lower confidence interval of the mean kendall's rank correlation coefficients (τ). Each value in the heat map is the difference between kendall's rank correlation and its lower confidence interval. Figure 14: upper CI for all the clustering methods, figure15: upper CI for Jaccard index, figure16: upper Ci for REGE index, figure17: upper CI for density-based modules, figure_nr 18: upper CI for prey-based modules, figure_nr 19: upper CI for predator-based modules, figure20: upper CI for group model";
writematrix(caption,"../supporting_information/Caption_figure_S" + (figure_nr-6) + "-S" + figure_nr + ".txt")