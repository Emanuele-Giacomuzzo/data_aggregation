%CHECK EVERYTHING IS FINE FOR A CERTAIN FOOD WEB
if checking == 1
    deleted_edge_percentage = ((numedges(digraph(A)) - numedges(digraph(A_DAG)))/numedges(digraph(A))) * 100
    for node = 1:length(A)
            xaxis(node) = normrnd(0.5,0.25)
        end
        plot(digraph(A), 'XData', xaxis, 'YData', TP);
        ylabel('Trophic position (TP)','FontSize',20)
        centralities_before_table = array2table(centralities_before,'VariableNames',centralities)
        t = tiledlayout(2,3); 
        for clustering = 1:length(clustering_methods)
            nexttile;
            heatmap(realised_link_ratio{clustering},'Title',clustering_methods(clustering))
        end
        dendrogram(branches_jaccard, 'Orientation', 'left')
        dendrogram(branches_rege,'Orientation', 'left')
        t = tiledlayout(2,3);
        for clustering = 1:length(clustering_methods)
            name = "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + name;
            kendall_matrix = readmatrix(path);
            nexttile;
            heatmap(linkage_n_strength, centralities, kendall_matrix, 'Title',clustering_methods(clustering),'ColorMap',color_style,'ColorLimits',[0 1])
        end
    end
 