coordinates_before = zeros(length(A_ecobase{chosen_web}),2);
for node = 1:length(coordinates_before)
    coordinates_before(node,1) = normrnd(0.5,0.25);
    coordinates_before(node,2) = TP(node);
end
file = "/Users/ema/github/data_aggregation/r/plotting/coordinates_original_web_" + web + ".csv";
writematrix(coordinates_before, file);