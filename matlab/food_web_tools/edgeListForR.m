function [edge_list_for_R] = edgeListForR(A,write)
%It is specifically useful to create a edge list that can be used in
%igraph in R. It produces 

edge_list_for_R=double.empty;
for i=1:length(A)
    for j=1:length(A)
        if A(i,j) ~= 0
            edge_list_for_R=[edge_list_for_R; i j A(i,j)];
        end
    end
end
edge_list_for_R=array2table(edge_list_for_R);

if write=="TRUE"
    writetable(edge_list_for_R,'edge_list_for_R.txt','Delimiter','\t','WriteVariableNames',false);
end

end