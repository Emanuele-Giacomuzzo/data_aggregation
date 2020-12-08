function[centrality_importance]=centralityimportance(adj_undir_binary, species_step_importance, number_of_steps)

centrality_importance=zeros(length(adj_undir_binary),1);
for i=1:number_of_steps
    centrality_importance=centrality_importance+species_step_importance{i};
end


end