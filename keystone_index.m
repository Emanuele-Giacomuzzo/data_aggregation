function [centrality_keystone] = keystone_index(adj_dir_weight)

adj_loopless=adj_dir_weight-diag(diag(adj_dir_weight));
without_predators=withoutpredators(adj_loopless);
nr_of_preys=nrofpreys(adj_loopless);
bottom_up_keystone=bottomupkeystone(adj_loopless,without_predators,nr_of_preys);



end