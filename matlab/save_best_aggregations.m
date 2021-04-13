%% TAKE OFF TP
if take_off_TP == 1
    best_kendall = best_kendall(1:end-1,:);
end

%% FIGURE
heatmap(clustering_better_names,centralities_latex,best_kendall,'ColorMap',color_style,'CellLabelFormat', '%.2f','FontSize', 25)
saveas(gcf,"../latex/figures/best_kendalls.png") 

%% CAPTION
caption = "Heat map of the best Kendall's rank correlation coefficient for each combination of clustering methods and centrality indices. The best correlation is selected across linkage methods and methods of determining interaction strength.";
writematrix(caption,"../latex/captions/caption_best_kendalls.txt")