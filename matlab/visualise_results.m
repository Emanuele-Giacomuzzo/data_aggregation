load ('../results/results.mat');
centralities=[ "nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"kindex";"kbu";"ktd";"kdir";"kindir";"TI1";"TI3";"TI5";"WI1";"WI3";"WI5";"STO1";"STO3";"STO5";"wSTO1";"wSTO3";"wSTO5";"TP"];
aggregations=["Jaccard_similarity";"Rege_similarity";"Density_modularity";"Prey_modularity";"Predator_modularity";"Group_model"];
c = size(best_kendall_by_food_web{1},1);
a = size(best_kendall_by_food_web{1},2);

best_kendall = cell(c,a);
best_percentage = cell(c,a);
best_weight = cell(c,a);
for centr = 1:c
    for aggr = 1:a
        for food_web = 1:length(best_kendall_by_food_web)
            if length(best_kendall_by_food_web{food_web}) > 1
                best_kendall{centr,aggr} = [best_kendall{centr,aggr}; best_kendall_by_food_web{food_web}(centr,aggr)];
                best_percentage{centr,aggr} = [best_percentage{centr,aggr}; best_percentage_by_food_web{food_web}(centr,aggr)];
                best_weight{centr,aggr} = [best_weight{centr,aggr}; best_weight_by_food_web{food_web}(centr,aggr)];
            end
        end
    end
end

minimum = zeros(c,a);
maximum = zeros(c,a);
sums = zeros(c,a);
means = zeros(c,a);
for food_web = 1:length(best_weight_by_food_web)
    if length(best_weight_by_food_web{food_web}) > 1
        for centr = 1:c
            for aggr = 1:a
                if best_weight_by_food_web{food_web}(centr,aggr) == "min"
                    minimum(centr,aggr) = minimum(centr,aggr)+1;
                elseif best_weight_by_food_web{food_web}(centr,aggr) == "max"
                    maximum(centr,aggr) = maximum(centr,aggr)+1;
                elseif best_weight_by_food_web{food_web}(centr,aggr) == "sum"
                    sums(centr,aggr) = sums(centr,aggr)+1;
                elseif best_weight_by_food_web{food_web}(centr,aggr) == "mean"
                    means(centr,aggr) = means(centr,aggr)+1;
                end
            end
        end
    end
end
minimum = minimum/86;
maximum = maximum/86;
sums = sums/86;
means = means/86;


%check normality according to aggregation method 
best_kendall_normality = double.empty;
best_percentage_normality = double.empty;
for centr = 1:c
    for agg = 1:a
        best_kendall_normality(centr,agg) = kstest(best_kendall{centr,agg});
        best_percentage_normality(centr,agg) = kstest(best_percentage{centr,agg});
    end
end

%check best kendall means 
best_kendall_means = zeros(c,a);
best_percentage_means = zeros(c,a);
for centr = 1:c
    for aggr = 1:a
        best_kendall_means(centr,aggr) = mean(best_kendall{centr,aggr});
        best_percentage_means(centr,aggr) = mean(best_percentage{centr,aggr});
    end
end

heatmap(strrep(aggregations,'_',' '),centralities,best_kendall_means,"CellLabelFormat","%.2f",'Title','Kendalls tau b','Colormap',parula);
heatmap(strrep(aggregations,'_',' '),centralities,best_percentage_means,"CellLabelFormat","%.2f",'Title','Link ratios','Colormap',parula);

weighted_centralities = [2 16 17 18 22 23 24];
X = categorical({'min','max','sum','means'});
t = tiledlayout(2,3);
for aggr = 1:a
    for centr = 1:c
        if length(find(weighted_centralities==centr)) > 0
            title(t,centralities(centr))
            nexttile
            Y = [minimum(2,1),maximum(2,1),sums(2,1),means(2,1)];
            bar(X,Y)
            title(strrep(aggregations(aggr),'_',' '))
            saveas(t,"barchart_" + centralities(centr) + ".png")
        end
    end
end

%working on it 
t = tiledlayout(2,3);
for aggr = 1:a
    for centr = 1:c
        title(t,centralities(centr))
        nexttile
        bar(best_percentage_means(:,c))
        title(strrep(aggregations(aggr),'_',' '))    
    end
end
