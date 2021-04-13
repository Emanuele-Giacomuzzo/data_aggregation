DC = centrality(graph(toundirected(A)),'degree');
WDC = calculateWDC(A);
CC = centrality(graph(toundirected(A)),'closeness');
BC = centrality(digraph(A),'betweenness');
[s,cs,ns] = calculateStatus(createDAG(A));
[kindex,kbu,ktd,kdir,kindir] = calculateKeystone(createDAG(A));
TI1 = calculateTI(A,1,"false");
TI3 = calculateTI(A,3,"false");
TI5 = calculateTI(A,5,"false");
WI1 = calculateTI(A,1,"true");
WI3 = calculateTI(A,3,"true");
WI5 = calculateTI(A,5,"true");
STO1 = calculateSTO(A, 1, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
STO3 = calculateSTO(A, 3, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
STO5 = calculateSTO(A, 5, TO_min_threshold, TO_max_threshold, TO_learning_rate, "binary");
wSTO1 = calculateSTO(A, 1, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
wSTO3 = calculateSTO(A, 3, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
wSTO5 = calculateSTO(A, 5, TO_min_threshold, TO_max_threshold, TO_learning_rate, "weighted");
TP = calculateTP(A);

centralities_original = double.empty;
for i = 1:length(centralities); 
    centralities_original = [centralities_original eval(centralities(i))];
end