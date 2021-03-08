cd '/Users/ema/github/data_aggregation/data/ecobase/A_loops_ucinet';
for i=1:length(A_loops)
    if (1<=i) && (i<=9)
        name = "A_loops_" + "00" +i;
    elseif (10<=i) && (i<=99)
        name = "A_loops_" + "0" + i;
    else
        name = "A_loops_" + i;
    end
    if isa(A_loops{i},'double') == 1
        writematrix(A_loops{i},name,'Delimiter','space')
    end
end

cd '/Users/ema/github/data_aggregation/data/ecobase/A_loopless';
for i=1:length(A_loopless)
    if (1<=i) && (i<=9)
        name = "A_loopless_" + "00" +i;
    elseif (10<=i) && (i<=99)
        name = "A_loopless_" + "0" + i;
    else
        name = "A_loopless_" + i;
    end
    if isa(A_loopless{i},'double') == 1
        writematrix(A_loopless{i},name)
    end
end