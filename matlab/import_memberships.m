initial_path = pwd();

for clustering = 1:length(clustering_methods)
    cd ((initial_path+"/../results/membership_") + clustering_methods(clustering))
    files = dir();
    hidden_files = length(files) - tot_web_nr;
    for file = (hidden_files+1):length(files)
        membership{(file - hidden_files),clustering} = readmatrix(files(file).name);
    end
end

cd('../../matlab')