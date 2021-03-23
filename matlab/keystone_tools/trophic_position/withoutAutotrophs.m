function [QA] = withoutAutotrophs(TA,diet)

QA=TA;
n = length(TA);
autotrophs=double.empty;
for i=1:n
    if diet(i)==0
        autotrophs=[autotrophs; i];
    end
end

QA(autotrophs,:) = []; 
QA(:,autotrophs) = [];%problem



end