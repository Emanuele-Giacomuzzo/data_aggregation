function[n_step]=stepeffectoverlap(adj_dir_weight, n_step, nr_of_steps)

for m=1:nr_of_steps
    for i=1:length(adj_dir_weight)
        for j=1:length(adj_dir_weight)
            n_step{m}=n_step{1}.^m;
        end
    end
end

end