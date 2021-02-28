function[TP]=trophicPosition(Aconnected)

A_db = tounweighted(Aconnected'); %binary
A_db = A_db - diag(diag(A_db)); %loop-less
n=length(A_db);
TA=fluxRatio(A_db);
diet=sum(TA,2);
QA = withoutAutotrophs(TA,diet);

IA=QA*0;
for i=1:length(IA)
    IA(i,i)=1;
end
vw=ones(length(IA),1);
TP_heterotrophs=linsolve((IA-QA),vw);

TP=zeros(n,1);
c=1;
for i=1:n
    if diet(i)==0
       TP(i)=0; 
    else 
        TP(i)=TP_heterotrophs(c);
        c=c+1;
    end
end

end