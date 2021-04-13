branches_rege = findBranches(A,"rege",REGE_matrices{web});
        membership{web,2} = cluster(branches_rege,'cutoff',hc_max_inconsistency); 
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt';
        writematrix(membership{web,2}, path);
