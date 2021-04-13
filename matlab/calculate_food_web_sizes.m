food_web_sizes = double.empty;
for web = 1:tot_web_nr
    food_web_sizes = [food_web_sizes; length(A_ecobase{web})];
end
food_web_sizes(food_web_sizes==1) = [];

histogram(nonzeros(food_web_sizes))
xlabel('Number of nodes')
ylabel('Number of food webs')
ylim([0 8]) 
ax = gca;
ax.FontSize = 30;
saveas(gcf,"/Users/ema/github/data_aggregation/latex/figures/food_web_sizes.png");
caption = "Size of the food webs we used in our study.";
writematrix(caption,"/Users/ema/github/data_aggregation/latex/captions/caption_food_web_sizes.txt");