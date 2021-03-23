function [wDC] = weightedDegree(A)

A = toundirected(A);

wDC = zeros(length(A),1);
for i = 1:length(A)
    for j = 1:length(A)
        wDC(i) = wDC(i) + A(i,j);
    end
end

end