function [pattern_modul_matrix] = squareBrackets(adj_dir_binary, indegree, outdegree, c_out)

pattern_modul_matrix=zeros(length(adj_dir_binary));
kl_kl_minus_one=0;

for l=1:length(adj_dir_binary)
    kl_kl_minus_one=kl_kl_minus_one+(indegree(l)*(indegree(l)-1));
end

for i=1:length(adj_dir_binary); 
    for j=1:length(adj_dir_binary);
        pattern_modul_matrix(i,j)=[[c_out(i,j)/kl_kl_minus_one-outdegree(i)*outdegree(j)/(sum(indegree)^2)]];
    end
end

end