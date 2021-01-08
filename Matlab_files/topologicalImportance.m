function [TI_species,TI_species_ratio]=topologicalImportance(A,num_steps)
cd topological_importance;

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

TI_species=sum(SI,2);
TI_species=TI_species/num_steps;
TI_species_ratio=TI_species/sum(TI_species);

%I guess I can just use a weighted network here. 

cd ..;

end