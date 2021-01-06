function[species_step_importance]=speciesstepimportance(steps_matrix,number_of_steps)

for i=1:number_of_steps;
species_step_importance{i}=sum(steps_matrix{i}, 2);
end

end