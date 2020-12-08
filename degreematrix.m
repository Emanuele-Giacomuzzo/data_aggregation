function [degree_m] = degreematrix (adj_undir_binary, food_web_undir)

degree_v=degree(food_web_undir);
for i=1:length(adj_undir_binary)
        degree_m(i,i)= degree_v(i);
end

end