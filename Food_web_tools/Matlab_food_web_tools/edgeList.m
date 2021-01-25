function [edge_list] = edgeList(A,platform)

n=length(A);
edge_list=[0 0 0];
for i=1:n
    for j=1:n
            if A(i,j) ~= 0
                if i<10
                    S="S0";
                else
                    S="S";
                end
                Si=strcat(S, num2str(i));
                if j<10
                    S="S0";
                else
                    S="S";
                end
                Sj=strcat(S, num2str(j));
                edge_list=[edge_list; Si, Sj, A(i,j)];
            end
            Si=strcat(S, num2str(i));            
    end
end
edge_list(1,:)=[];

edge_list=array2table(edge_list);
edge_list.Properties.VariableNames = {'Prey' 'Predator' 'Link'};

writetable(edge_list,'edge_list.txt','Delimiter','\t','WriteVariableNames',false);

end