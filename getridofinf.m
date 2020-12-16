function [path_length] = getridofinf(path_length)

for i=1:length(path_length)
    for j=1:length(path_length)
        if path_length(i,j) > 100
            path_length(i,j)=0;
        end
    end
end

end