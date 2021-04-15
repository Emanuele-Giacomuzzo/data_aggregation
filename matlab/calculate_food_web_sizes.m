food_web_sizes = double.empty;
for web = 1:tot_web_nr
    food_web_sizes = [food_web_sizes; length(A_ecobase{web})];
end
food_web_sizes(food_web_sizes==1) = [];