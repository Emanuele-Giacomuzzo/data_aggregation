function[]=topologicalImportance()

load web.mat;
num_steps=3;
n=length(web);

TI=oneStepTI(web);

CI=ones(n);
CI=diag(CI);
CI=diag(CI);

SI=zeros(n);

for i=1:num_steps
    CI=CI*TI;
    SI=SI+CI;
end

TI_species=sum(SI,2);
TI_species=TI_species/num_steps;
TI_species_ratio=TI_species/sum(TI_species);


%I guess I can just use a weighted network here. 

end