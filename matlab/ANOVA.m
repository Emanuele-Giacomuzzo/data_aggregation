[H, pValue, SWstatistic] = swtest(best_percentage(:,1));
[p,tbl,stats] = anova1(best_percentage);
[p2,tbl2,stats2] = anova1(best_percentage');
