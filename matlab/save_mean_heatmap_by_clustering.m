%% FIGURES
figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{1}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size);
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{2}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size);
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{3}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size);
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{4}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size);
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{5}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size);
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength, centralities_figures, kendall_mean{6}, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', medium_font_size)
saveas(gcf, "../supporting_information/figures/Figure_S" + figure_nr + ".png")