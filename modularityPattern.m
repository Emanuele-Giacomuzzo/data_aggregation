function [modularity_pattern_inv] = modularityPattern(M)

modularity_pattern_inv=1/sum(sum(M{1}*M{2}));

end