function[interactor]=interactormatrix(average_effect, threshold)

%interactor matrix
for i=1:length(average_effect)
    for j=1:length(average_effect)
        if average_effect(i,j) > threshold
            interactor(i,j)='S';
        else
            interactor(i,j)='W';
        end
    end
end


end