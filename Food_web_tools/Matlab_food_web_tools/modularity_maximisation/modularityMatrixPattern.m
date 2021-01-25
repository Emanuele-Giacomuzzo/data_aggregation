function[B_matrix_patt]=modularityMatrixPattern(adj_dir_binary,c_out,in_times_in_minus_one, outdegree,indegree)

B_matrix_patt=zeros(length(adj_dir_binary));

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        if i==j
            B_matrix_patt(j,i)=0;
        else
            B_matrix_patt(j,i)=c_out(j,i)/in_times_in_minus_one-outdegree(j)*outdegree(i)/sum(indegree.^2);
        end
    end
end

end