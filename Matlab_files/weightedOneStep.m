function [weighted_one_step] = weightedOneStep(adj_dir_weight)

n=length(adj_dir_weight);
weight_proportion=zeros(n);
weighted_one_step=zeros(n);
total_intake=sum(adj_dir_weight,2);

for i=1:n
    for j=1:n
        if adj_dir_weight(i,j)>0
            weight_proportion(i,j)=adj_dir_weight(i,j)/total_intake(j);
        end
    end
end

weighted_one_step=weight_proportion./total_intake;

end