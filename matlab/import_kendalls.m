for clustering = 1:length(clustering_methods)
    cd ('/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering));
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        kendalls{(file - hidden_files),clustering} = readmatrix(files(file).name);
    end
end