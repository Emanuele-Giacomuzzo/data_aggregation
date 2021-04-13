%% FIGURES
tiledlayout(1, 1)

heatmap(aggregation_methods, centralities_figures, all_mean_kendalls, 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', 15)
saveas(gcf, "../latex/figures/mean_kendalls_a.png") 

heatmap(centralities_figures, aggregation_methods, all_mean_kendalls', 'ColorMap', color_style, 'ColorLimits', [0 1], 'CellLabelFormat',  '%.2f',  'FontSize', 7)
saveas(gcf, "../latex/figures/mean_kendalls_b.png")

%% CAPTION
caption1 = "Heat map describing the kendall's rank correlation (τ) between the ranking of the nodes in the original food web and in the aggregated food web. On the x axis,  there is the aggregation method,  which is described by three components. The first component is the clustering algorithm. The second one is the linkage method. The third one is the method by which we determined the interaction strength. On the y axis,  there are the centrality indices.";
caption2 = "Jaccard = Hierachical clustering using Jaccard index,  REGE = Hierarchical clustering using REGE index,  density = clustering of density-based modules,  prey = clustering of prey-based modules,  predator = clustering of predator-based modules,  groups = clustering of groups.";
caption3 = "NMAX = maximum linkage,  25% = at least 25% of links realised to consider a connection,  50% = at least 25% of links realised to consider a connection,  75% = at least 75% of links realised to consider a connection,  NMIN = 100% all possible links realised.";
caption4 = "min = minimum interaction strength,  max = maximum interaction strength,  sum = sum of interaction strength,  mean = mean interaction strength.";
caption5 = "DC = degree centrality,  WDC = weighted degree centrality,  CC = closeness centrality,  BC = betweenness centrality,  s = status index,  cs = constrostatus index,  ns = net status index,  kindex = keystone index,  kbu = bottom-up keystone index,  ktd = top-down keystone index,  kdir = directed keystone index,  kindir = indirected keystone index,  TI1 = 1-step topological imoprtance,  TI3 = 3-step topological importance,  TI5 = 5-step topological importance,  WI1 = 1-step weighted topological importance,  WI3 = 3-step weighted topological importance,  WI5 = 5-step weighted topological importance,  STO1 = 1-step species uniqueness,  STO3 = 3-step species uniqueness,  STO5 = 5-step species uniqueness,  wSTO1 = 1-step weighted species uniqueness,  wSTO3 = 3-step weighted species uniqueness,  wSTO5 = 5-step weighted species uniqueness,  TP = trophic position.";
caption = caption1 + caption2 + caption3 + caption4 + caption5;
writematrix(caption, "../latex/captions/caption_mean_kendalls.txt", 'QuoteStrings', false);