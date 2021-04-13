rank_table_ci = [header; centralities(1:end-1) rankings_ci(1:end-1,:)];
writetable(rank_table_ci, '../supporting_information/rank_table_ci.tex');

rank_table_aggregations = [header; centralities(1:end-1) rankings_link_n_strength(1:end-1,:)];
writetable(rank_table_aggregations, '../supporting_information/rank_table_aggregations.tex');