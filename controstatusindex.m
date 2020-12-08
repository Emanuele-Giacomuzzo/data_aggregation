function [controstatus] = controstatusindex(graph)

flipped_graph=flipedge(graph);

path_length_inverse=distances(flipped_graph,'Method','unweighted');
for i=1:length(path_length_inverse)
    for j=1:length(path_length_inverse)
        if path_length_inverse(i,j) > 100
            path_length_inverse(i,j)=0;
        end
    end
end

for i=1:length(path_length_inverse)
A=path_length_inverse(i,:);
controstatus(i)=sum(A);
end


end
