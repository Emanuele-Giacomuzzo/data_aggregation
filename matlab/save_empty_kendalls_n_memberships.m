%% SAVE EMPTY KENDALLS
for clustering = 1:length(clustering_methods)
    path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
    writematrix(A_ecobase{web}, path);
end

%% SAVE EMPTY JACCARD & REGE MEMBERSHIPS
path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt'
writematrix(A_ecobase{web}, path);
path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt'
writematrix(A_ecobase{web}, path);