function[interactor]=interactormatrix(adj_dir_weight,average_effect, threshold)

%interactor matrix
for i=1:length(adj_dir_weight)
    for j=1:length(adj_dir_weight)
        if average_effect(i,j) > threshold
            interactor(i,j)='S';
        else
            interactor(i,j)='W';
        end
    end
end


end