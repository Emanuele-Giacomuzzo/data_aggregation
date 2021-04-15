heatmap(aggregation_methods, centralities_figures, all_min_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S"+figure_nr+".png")

figure_nr = figure_nr + 1;
heatmap(aggregation_methods, centralities_figures, all_max_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/figures/Figure_S"+figure_nr+".png")