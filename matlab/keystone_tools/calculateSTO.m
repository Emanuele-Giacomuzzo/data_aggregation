function [STO] = topologicalOverlap(A, nr_of_steps, min_threshold, max_threshold, learning_rate, weight)

if weight == "binary"
    A(A > 0) = 1;
end

A = A - diag(diag(A)); %loopless
degree_matrix = computeDegreeMatrix(A,weight);
threshold = [min_threshold:learning_rate:max_threshold];

for thresh = 1:length(threshold)
    TI1_matrix = calculateTI1(A, degree_matrix);
    for step = 1:nr_of_steps
        TIn_matrices{step} = TI1_matrix .^ step; 
    end
    average_effect_matrix = calculateTIAverage(A, TIn_matrices, nr_of_steps);
    interactor_matrix = computeInteractorMatrix(average_effect_matrix, threshold(thresh));
    overlap_matrix = computeTOMatrix(interactor_matrix);
    TO(:,thresh) = sum(overlap_matrix, 2);
end

STO = sum(TO,2);

end