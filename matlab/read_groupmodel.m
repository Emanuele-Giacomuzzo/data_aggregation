%Read all the files produced by the signed group model. 
setwd = '/Users/ema/github/data_aggregation/data/ecobase/group_model';
myfolder = '/Users/ema/github/data_aggregation/data/ecobase/group_model';
file_pattern = fullfile(myfolder, "*.txt");
files = dir(file_pattern);

count=0;
group_model = cell(length(A_loops),1);
for k=1:length(group_model)
    if length(A_loops{k}) > 1
        count = count +1;
        file_name = files(count).name;
        group_model{k} = readmatrix(file_name,'Delimiter', ' ');
        group_model{k} = (group_model{k})';
        group_model{k} = rmmissing(group_model{k});
        group_model{k} = group_model{k} + 1;
    end
end