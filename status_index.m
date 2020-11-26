function [status] = status_index(graph)

path_length=distances(graph,'Method','unweighted');
for i=1:length(path_length)
    for j=1:length(path_length)
        if path_length(i,j) > 100
            path_length(i,j)=0;
        end
    end
end

for i=1:length(path_length)
A=path_length(i,:);
status(i)=sum(A);
end

end