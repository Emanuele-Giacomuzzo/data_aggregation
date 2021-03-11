clc,clear; cd '/Users/ema/github/data_aggregation/matlab'; warning('off','all');
load('../data/ecobase/ecobase.mat');

cd '/Users/ema/github/data_aggregation/data/ecobase/density_modularity';
fileinfo = dir();
fnames = {fileinfo.name};
fnames = fnames(3:length(fnames));
density_modularity = cell(length(A_loops),1);
count = 0;
for i = 1:length(A_loops)
    if isa(A_loops{i},'double') == 1
        count = count +1;
        density_modularity{i} = readmatrix(char(fnames(count)));
    else
        density_modularity{i} = A_loops{i};
    end
end

cd '/Users/ema/github/data_aggregation/data/ecobase/predator_modularity';
fileinfo = dir();
fnames = {fileinfo.name};
fnames = (fnames(3:length(fnames)))';
predator_modularity = cell(length(A_loops),1);
count = 0;
for i = 1:length(A_loops)
    if isa(A_loops{i},'double') == 1
        count = count +1;
        predator_modularity{i} = readmatrix(char(fnames(count)));
    else
       predator_modularity{i} = A_loops{i};
    end
end

cd '/Users/ema/github/data_aggregation/data/ecobase/prey_modularity';
fileinfo = dir();
fnames = {fileinfo.name};
fnames = fnames(4:length(fnames));
prey_modularity = cell(length(A_loops),1);
count = 0;
for i = 1:length(A_loops)
    if isa(A_loops{i},'double') == 1
        count = count +1;
        prey_modularity{i} = readmatrix(char(fnames(count)));
    else
        prey_modularity{i} = A_loops{i};
    end
end

for i = 1:length(density_modularity)
    density_modularity{i} = density_modularity{i}+1;
end

for i = 1:length(predator_modularity)
    predator_modularity{i} = predator_modularity{i}+1;
end

for i = 1:length(density_modularity)
    prey_modularity{i} = prey_modularity{i}+1;
end
