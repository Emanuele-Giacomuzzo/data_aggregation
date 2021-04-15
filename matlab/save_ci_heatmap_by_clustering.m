%% FIGURES OF CI MAX
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_max_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png");

%% FIGURS OF CI MIN 
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{1},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{2},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{3},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{4},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{5},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_figures,kendall_ci_min_relative{6},'ColorMap',color_style,'ColorLimits',[0 0.2],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/figures/Figure_S" + figure_nr + ".png")