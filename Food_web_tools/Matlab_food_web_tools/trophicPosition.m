function[TP]=trophicPosition(Aconnected)

A_db=tounweighted(Aconnected');

n=length(A_db);
TP=zeros(n,1);

TA=fluxRatio(A_db);
diet=sum(TA,2);
QA = withoutAutotrophs(TA,diet); %problem

%Create a matrix with 1s on the diagonal (IA) and a vector with ones (vw).
IA=QA*0;
for i=1:length(IA)
    IA(i,i)=1;
end
vw=ones(length(IA),1);

TP_heterotrophs=linsolve((IA-QA),vw);

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