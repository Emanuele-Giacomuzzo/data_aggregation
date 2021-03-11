clc,clear; cd '/Users/ema/github/data_aggregation/matlab'; warning('off','all');
load('../data/ecobase/ecobase.mat');
best_kendall=cell(length(A_loops),1);
best_percentage=cell(length(A_loops),1);
best_weight=cell(length(A_loops),1);

for i = 1:length(A_loops)
    if length(A_loops{i})>1 && i ~= 63 && i ~= 87
        best_kendall{i} = readmatrix("best_kendall_"+i);
        best_percentage{i} = readmatrix("best_percentage_"+i);
        best_weight{i} = readmatrix("best_weight_"+i+".txt",'OutputType','string','Delimiter',',');
    end
end