%Check how the number of incosistency changes the number of clusters
hc_max_inconsistency = [0.1:0.1:1];

for web = 1:length(A_ecobase)
    if length(A_ecobase{web}) > 1
        A = A_ecobase{web};
        for inconsistency = 1:length(hc_max_inconsistency)
            branches_jaccard = findBranches(A,"jaccard");
            membership_jaccard = cluster(branches_jaccard,'cutoff',hc_max_inconsistency(inconsistency));
            cluster_ratio(inconsistency) = max(membership_jaccard)/length(membership_jaccard);  
        end
        plot(hc_max_inconsistency,cluster_ratio)
        title('Jaccard index: how the inconsistency of the branches produces different numbers of clusters')
        xlabel('Max inconsistency of the branches') 
        ylabel('Number of clusters/ Number of nodes') 
        if web ==1; hold; end
    end
end
saveas(gcf,'/Users/ema/github/data_aggregation/pics/inconsistencies_jaccard.png')

for web = 1:length(A_ecobase)
    if length(A_ecobase{web}) > 1
        A = A_ecobase{web};
        for inconsistency = 1:length(hc_max_inconsistency)
            branches_rege = findBranches(A,"rege",REGE_matrices{web});
            membership_rege = cluster(branches_rege,'cutoff',hc_max_inconsistency); 
            cluster_ratio(inconsistency) = max(max(membership_rege))/length(membership_rege);
        end
        plot(hc_max_inconsistency,cluster_ratio)
        title('REGE index: how the inconsistency of the branches produces different numbers of clusters')
        xlabel('Max inconsistency of the branches') 
        ylabel('Number of clusters/ Number of nodes') 
        if web ==1; hold; end
    end
end
saveas(gcf,'/Users/ema/github/data_aggregation/pics/inconsistencies_rege.png')


   