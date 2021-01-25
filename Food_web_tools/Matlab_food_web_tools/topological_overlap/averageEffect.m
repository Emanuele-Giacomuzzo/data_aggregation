function[average_effect]=averageeffect(adj_dir_weight, n_step, nr_of_steps)

average_effect=zeros(length(adj_dir_weight));

for n=1:nr_of_steps
    average_effect=average_effect+n_step{n};
end

average_effect=average_effect*(1/nr_of_steps);

end