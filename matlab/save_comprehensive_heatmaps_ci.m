heatmap(aggregation_methods, centralities_latex, all_min_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")
writematrix(caption,'../supporting_information/min_ci_all.txt')

heatmap(aggregation_methods, centralities_latex, all_max_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")
writematrix(caption,"../figures/Caption_figure_S" + figure_nr + ".txt")