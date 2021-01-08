function [outputArg1,outputArg2] = rightNetwork(inputArg1,inputArg2)

if centrality=="degree" || centrality=="betweenness" || centrality=="closeness" || centrality=="TI" %Undirected binary
    adj_und=toundirected(adj);
    network_und=graph(adj_und);
end 
if centrality=="status" || centrality=="keystone" end %Directed binary
if centrality=="TO" || centrality=="STO" end %Directed weighted

end