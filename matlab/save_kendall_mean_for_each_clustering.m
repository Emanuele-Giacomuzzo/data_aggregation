figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{1},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{2},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{3},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{4},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{5},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size);
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png");

figure_nr = figure_nr + 1;
heatmap(linkage_n_strength,centralities_latex,kendall_mean{6},'ColorMap',color_style,'ColorLimits',[0 1],'CellLabelFormat', '%.2f', 'FontSize',medium_font_size)
saveas(gcf,"../supporting_information/Figure_S" + figure_nr + ".png")
caption = "Sections of Figure 3, which allows to read the single values. Figure S1= Jaccard, Figure S2= REGE, Figure S3= Density-based modules, Figure S4= Prey-based modules, Figure S5= Predator-based modules, Figure S6= Group model.";
writematrix(caption, "../supporting_information/Caption_figure_S" + (figure_nr-5) + "-S" + figure_nr + ".txt")
