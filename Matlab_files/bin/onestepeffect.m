function[n_step]=onestepeffect(adj_dir_weight, degree_m)

n_step{1}=zeros(length(adj_dir_weight));

for i=1:length(adj_dir_weight)
    for j=1:length(adj_dir_weight)
        if adj_dir_weight(i,j)>0
            n_step{1}(i,j)=1/(degree_m(j,j));
        end
    end
end
    
end