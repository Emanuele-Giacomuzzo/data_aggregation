function [TI]=topologicalImportance(A,num_steps)

A_db=tounweighted(A);  
A_ub=toundirected(A_db);

n=length(A_ub);
TI=oneStepTI(A_ub);
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