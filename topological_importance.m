function[centrality_importance]=(adj_undir_binary,food_web_undir)

degree_v=degree(food_web_undir);
for i=1:length(degree_v)
        degree_m(i,i)= degree_v(i);
end

for i=1:length(adj_undir_binary)
    for j=1:length(adj_undir_binary)
        if adj_undir_binary(i,j) > 0;
            one_step(j,i)=1/degree_m(i,i);
        end
    end
end

for i=1:length(one_step);
    for j=1:length(one_step);
        if one_step(i,j) > 0;
        for z=1:length(one_step);
end
