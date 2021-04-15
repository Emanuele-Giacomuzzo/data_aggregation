rank_table_ci = [header; rankings_ci(1:end-1,:)];
writematrix(rank_table_ci, '../results/tables/rank_table_ci.txt');

rank_table_aggregations = [header; rankings_link_n_strength(1:end-1,:)];
writematrix(rank_table_aggregations, '../results/tables/rank_table_aggregations.txt');