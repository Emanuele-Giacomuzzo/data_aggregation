function [wDC] = weightedDegree(A)

A_uw=toundirected(A);

wDC=zeros(length(A),1);
for i=1:length(A_uw)
    for j=1:length(A_uw)
        wDC(i)=wDC(i)+A_uw(i,j);
    end
end

end