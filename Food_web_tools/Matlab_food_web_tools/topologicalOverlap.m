function [STO]=topologicalOverlap(A,nr_of_steps,min_threshold,max_threshold,learning_rate)
%I will take off the loops. I'm not sure if this will help. But I don't
%think it will be a problem. 

TO=zeros([length(A) 1]); 
STO=zeros([length(A) 1]);

degree_matrix=degreeMatrix(A);
threshold=[min_threshold:learning_rate:max_threshold];

for i=1:length(threshold)
step_effect=oneStepEffect(A, degree_matrix);
step_effect=stepEffectOverlap(A,step_effect, nr_of_steps);
average_effect=averageEffect(A,step_effect, nr_of_steps);
interactor=interactorMatrix(average_effect, threshold(i));
overlap_matrix=topologicalOverlapMatrix(interactor);

TO(:,i)=sum(overlap_matrix, 2); 
end

STO=sum(TO,2);

end