%% FIGURES
heatmap(aggregation_methods, centralities_figures, all_min_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/figure_min_ci.png")

heatmap(aggregation_methods, centralities_figures, all_max_ci, 'ColorMap', color_style, 'ColorLimits', [0 0.2], 'CellLabelFormat', '%.2f', 'FontSize',small_font_size)
saveas(gcf,"../supporting_information/figure_max_ci_all.png")

%% CAPTIONS
writematrix(caption,"../supporting_information/caption_min_ci.txt")
writematrix(caption,"../supporting_information/caption_max_ci.txt")