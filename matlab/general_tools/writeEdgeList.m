function [edge_list] = writeEdgeList(A,platform)

edge_list = [0 0 0];
for prey = 1:length(A)
    for predator = 1:length(A)
        if A(prey,predator) ~= 0
            if prey < 10
                S = "S0";
            else
                S = "S";
            end
            Si = strcat(S, num2str(prey));
            if predator < 10
                S = "S0";
            else
                S = "S";
            end
            Sj = strcat(S, num2str(predator));
            edge_list = [edge_list; Si, Sj, A(prey,predator)];
        end
        Si = strcat(S, num2str(prey));
    end
end

edge_list(1,:) = [];

edge_list = array2table(edge_list);
edge_list.Properties.VariableNames = {'Prey' 'Predator' 'Link'};

writetable(edge_list, 'edge_list.txt', 'Delimiter', ',', 'WriteVariableNames', false);

end

function[edgelist] = transformToBinaryEdgelist(A)

edgelist = double.empty; 

for node_from = 1:length(A)
    for node_to = 1:length(A)
        if A(node_from,node_to) ~= 0
            edgelist = [edgelist; node_from node_to];
        end
    end
end

end

function [igraph_edgelist] = writeIgraphEdgelist(A)
%It is specifically useful to create a edge list that can be used in
%igraph in R.

igraph_edgelist=double.empty;
for node_from=1:length(A)
    for node_to=1:length(A)
        if A(node_from,node_to) ~= 0
            igraph_edgelist = [igraph_edgelist; node_from node_to A(node_from,node_to)];
        end
    end
end

igraph_edgelist = array2table(igraph_edgelist);
writetable(igraph_edgelist,'igraph_edgelist.txt','Delimiter',',','WriteVariableNames',false);

end