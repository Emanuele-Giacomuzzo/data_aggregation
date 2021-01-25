function[n_step]=onestepeffect(A, degree_matrix)

n_step{1}=zeros(length(A));

for i=1:length(A)
    for j=1:length(A)
        if A(i,j)>0
            n_step{1}(i,j)=1/(degree_matrix(j,j));
        end
    end
end
    
end