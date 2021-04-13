cd '/Users/ema/github/data_aggregation/results/REGE_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    REGE_matrices{(file - hidden_files),1} = readmatrix(files(file).name);
end

cd '../../matlab'