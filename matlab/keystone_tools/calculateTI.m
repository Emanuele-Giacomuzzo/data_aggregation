function [TI]=topologicalImportance(A,num_steps,weighted)

A = toundirected(A); %undirected
if weighted=="false"
    A(A > 0) = 1; %binary
end

n=length(A);
TI=oneStepTI(A);
CI=ones(n);
CI=diag(diag(CI));
SI=zeros(n);

for i=1:num_steps
    CI=CI*TI;
    CI(isnan(CI))=0; %Nan appears if one of the species inside the web is not connected to the others.
    SI=SI+CI;
end

TI=sum(SI,2);
TI=TI/num_steps;

%I guess I can just use a weighted network here. 

end