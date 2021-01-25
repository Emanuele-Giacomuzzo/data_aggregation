function [TA] = fluxRatio(A)

sumrowsA=sum(A,2);
n=length(A);
TA=zeros(n);
for i=1:n
    for j=1:n
        if A(i,j) ~= 0
            TA(i,j)=A(i,j)/sumrowsA(i);
        end
    end
end

end