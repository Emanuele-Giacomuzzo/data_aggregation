function[centrality_importance]=topological_importance(adj_undir_binary,food_web_undir, number_of_steps)


degree_m=degreematrix(adj_undir_binary, food_web_undir);
steps_matrix=stepsmatrix(adj_undir_binary, degree_m, number_of_steps);
species_step_importance=speciesstepimportance(steps_matrix,number_of_steps);
centrality_importance=centralityimportance(adj_undir_binary, species_step_importance, number_of_steps);

end