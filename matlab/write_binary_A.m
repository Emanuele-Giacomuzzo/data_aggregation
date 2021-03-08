for i=1:length(A_loops_binary)
    if length(A_loops_binary{i})>1
        name = "A_loops_binary_" + i;
        writematrix(A_loops_binary{i},name,'Delimiter',' ');
    end
end