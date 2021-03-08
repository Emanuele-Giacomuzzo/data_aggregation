string_array = string.empty;
for i=1:length(A_loops_binary)
    if length(A_loops_binary{i})>1
        path = "/Users/ema/github/data_aggregation/data/ecobase/A_loops_binary/A_loops_binary_" + i + ".txt";
        print = "./FindGroups " + length(A_loops_binary{i}) + " " + path + " 800546 100000 100";
        string_array = [string_array; print];
    end
end

writematrix(string_array);