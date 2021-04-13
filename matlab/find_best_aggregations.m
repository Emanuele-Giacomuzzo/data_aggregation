best_kendall = zeros(length(centralities),length(clustering_methods));
best_link_n_strength = zeros(length(centralities),length(clustering_methods));
ci_min_of_best = zeros(length(centralities),length(clustering_methods));
ci_max_of_best = zeros(length(centralities),length(clustering_methods));
for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(centralities)
        [best_kendall(centralityI,clustering), best_link_n_strength(centralityI,clustering)] = max(kendall_mean{clustering}(centralityI,:));
        ci_min_of_best(centralityI,clustering) = kendall_ci_min{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
        ci_max_of_best(centralityI,clustering) = kendall_ci_max{clustering}(centralityI, best_link_n_strength(centralityI,clustering));
    end
end
ci_min_of_best = round(ci_min_of_best,2);
ci_max_of_best = round(ci_max_of_best,2);

heatmap(clustering_better_names,centralities_latex,best_kendall,'ColorMap',color_style,'CellLabelFormat', '%.2f','FontSize', 25)
saveas(gcf,"../latex/figures/best_kendalls.png") 
caption = "Heat map of the best Kendall's rank correlation coefficient for each combination of clustering methods and centrality indices. The best correlation is selected across linkage methods and methods of determining interaction strength.";
writematrix(caption,"../latex/captions/caption_best_kendalls.txt")