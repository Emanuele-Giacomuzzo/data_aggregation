header = ["Index" "C1", "C2", "C3", "C4", "C5", "C6" ];
rank_table = [header; centralities_latex_2(1:end-1) rankings(1:end-1,:)];
writematrix(rank_table, "../latex/tables/rank_table.txt")