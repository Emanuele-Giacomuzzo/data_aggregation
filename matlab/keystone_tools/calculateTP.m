function[TP]=trophicPosition(A)

A(A > 0) = 1; %binary
A = A - diag(diag(A)); %loop-less

TA = fluxRatio(A);
diet = sum(TA,2);
QA = withoutAutotrophs(TA,diet);

IA = QA*0;
for i = 1:length(IA)
    IA(i,i) = 1;
end
vw = ones(length(IA),1);
TP_heterotrophs = linsolve((IA-QA),vw);

TP = zeros(length(A),1);
c = 1;
for i = 1:length(A)
    if diet(i) == 0
       TP(i) = 0; 
    else 
        TP(i) = TP_heterotrophs(c);
        c = c+1;
    end
end

TP = TP + 1;

end