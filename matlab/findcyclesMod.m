function pathCell = findcyclesMod(A)
%https://uk.mathworks.com/matlabcentral/answers/515624-finding-cycles-in-directed-graph
%It doesn't work. However, I might find the way of making it work. 

G = digraph(A);

numNodes = length(A); 
pathCell = {};
for n = 1:numNodes
   [D,P]=graphtraverse(A,n);
   for d = D
       if G(d,n)
           pathCell{end+1} = graphpred2path(P,d);
       end
   end
   G(n,:)=0; 
end

end
