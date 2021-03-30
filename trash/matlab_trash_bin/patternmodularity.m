%Pattern-based modularity
c_out=sharedOutLink(adj_dir_binary);
M{1}=squareBrackets(adj_dir_binary,indegree,outdegree,c_out);
M{2}=zeros(length(adj_dir_binary));
M_min{1}=square_brackets;M_min{2}=zeros(length(adj_dir_binary));
M_max{1}=square_brackets;M_max{2}=ones(length(adj_dir_binary));

modularity_pattern=modularityPattern(M);
fun=@modularityPattern;

modularity=simulannealbnd(fun, M, M_min, M_max);

