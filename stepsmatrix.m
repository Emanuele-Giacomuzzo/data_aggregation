function[steps_matrix]=stepsmatrix(adj_undir_binary, degree_m, number_of_steps)

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

end