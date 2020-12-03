function[centrality_importance]=topological_importance(adj_undir_binary,food_web_undir, number_of_steps)

degree_v=degree(food_web_undir);
for i=1:length(adj_undir_binary)
        degree_m(i,i)= degree_v(i);
end


n=number_of_steps;
for i=1:n;
steps_matrix{i}=zeros(length(adj_undir_binary));
end;


for i=1:length(adj_undir_binary)
    for j=1:length(adj_undir_binary)
        if adj_undir_binary(i,j) > 0;
            steps_matrix{1}(i,j)=1/degree_m(j,j);
        end
    end
end


for m=2:n;
for i=1:length(adj_undir_binary);
    for j=1:length(adj_undir_binary);
        if steps_matrix{m-1}(i,j) > 0;
        for z=1:length(adj_undir_binary);
            if steps_matrix{m-1}(j,z) > 0;
                steps_matrix{m}(i,z)=steps_matrix{m}(i,z)+[steps_matrix{m-1}(i,j)*steps_matrix{m-1}(j,z)];
            end
        end
        end
    end
end
end


for i=1:number_of_steps;
species_step_importance{i}=sum(steps_matrix{i}, 2);
end

centrality_importance=zeros(length(adj_undir_binary),1);
for i=1:number_of_steps
    centrality_importance=centrality_importance+species_step_importance{i};
end