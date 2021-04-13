cd '../data/adjacency_matrices'
files = dir();
hidden_files = length(files) - tot_web_nr;
for file = (hidden_files + 1):length(files)
    A_ecobase{(file - hidden_files)} = readmatrix(files(file).name);
end

cd '../../matlab'