function[n_step]=nstepmatrices(adj_dir_weight)

%It is used for topological overlap.

n_step{1}=adj_dir_weight;
for n=2:10
n_step{n}=n_step{n-1}.^n;
end

end