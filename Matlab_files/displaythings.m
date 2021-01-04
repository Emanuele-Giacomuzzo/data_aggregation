a=input('What would you like to see? [original food web/Jaccard dendrogram/nothing]');
if a=='original food web'
    plot(food_web,'NodeLabel',node_names);
elseif a=='Jaccard dendrogram'
    dendrogram(jaccard_average, 63,'Orientation','left','Labels',node_names);
end
