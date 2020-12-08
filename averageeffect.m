function[average_effect]=averageeffect(adj_dir_weight,n_step)

%It's useful for topological overlap.

addition=adj_dir_weight;
for n=1:10
    addition=addition+n_step{n};
end

average_effect=(1/n)*addition;

end