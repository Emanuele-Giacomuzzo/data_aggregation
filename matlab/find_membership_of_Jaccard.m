branches_jaccard = findBranches(A,"jaccard");
membership{web,1} = cluster(branches_jaccard,'cutoff',hc_max_inconsistency);
path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt';
writematrix(membership{web,1}, path);
