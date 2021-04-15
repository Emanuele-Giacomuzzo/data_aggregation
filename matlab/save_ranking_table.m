header = ["C1", "C2", "C3", "C4", "C5", "C6" ];
rank_table = [header; rankings(1:end-1,:)];
writematrix(rank_table, "../results/tables/rank_table.txt");