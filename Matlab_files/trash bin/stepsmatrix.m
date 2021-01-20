function[steps_matrix]=stepsmatrix(adj_undir_binary, degree_m, number_of_steps)

for m=1:number_of_steps
    steps_matrix{m}=zeros(length(adj_undir_binary));
    for i=1:length(adj_undir_binary)
        for j=1:length(adj_undir_binary)
            if m==1
                if adj_undir_binary(i,j) > 0
                    steps_matrix{1}(i,j)=1/degree_m(j,j); 
                end
            elseif m>1
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

end