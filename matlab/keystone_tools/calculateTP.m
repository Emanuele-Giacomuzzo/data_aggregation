function[TP] = calculateTP(A)

A = A - diag(diag(A));

intake_ratio = computeIntakeRatioMatrix(A);
tot_intake = sum(intake_ratio);
intake_ratio_heterotrophs = deleteAutotrophs(intake_ratio,tot_intake);

diagonal_matrix = intake_ratio_heterotrophs * 0;
for heterotroph = 1:length(diagonal_matrix)
    diagonal_matrix(heterotroph,heterotroph) = 1;
end

solutions = ones(length(diagonal_matrix),1);
coefficients = (diagonal_matrix - intake_ratio_heterotrophs)';
TP_heterotrophs = linsolve(coefficients,solutions) + 1;

TP = zeros(length(A),1);
heterotroph = 1;
for predator = 1:length(A)
    if tot_intake(predator) == 0
       TP(predator) = 1; 
    else
        TP(predator) = TP_heterotrophs(heterotroph);
        heterotroph = heterotroph + 1;
    end
end

end