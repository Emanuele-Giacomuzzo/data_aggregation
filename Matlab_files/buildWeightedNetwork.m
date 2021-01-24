function [A_clustered] = buildWeightedNetwork(A,A_clustered,membership,centrality_type,weight)

A_clustered_binary=A_clustered;
A_clustered_min=zeros(length(A_clustered));
A_clustered_mean=zeros(length(A_clustered));
A_clustered_max=zeros(length(A_clustered));
A_clustered_sum=zeros(length(A_clustered));
if centrality_type=="nwDC" || centrality_type=="STO"
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            if A_clustered(i,j)==1
                COUNT=0;
                SUM=0;
                MAX=0;
                MIN=10^10;
                for k=1:length(A)
                    for l=1:length(A)
                        if membership(k) == i && membership(l) == j
                            COUNT = COUNT + 1;
                            SUM = SUM + A(k,l);
                            if A(k,l) < MIN 
                                MIN = A(k,l);
                            end
                            if A(k,l) > MAX
                                MAX = A(k,l);
                            end
                        end
                    end
                end
                A_clustered_mean(i,j) = SUM/COUNT;
                A_clustered_sum(i,j) = SUM;
                A_clustered_min(i,j) = MIN;
                A_clustered_max(i,j) = MAX;
            end
        end
    end
    if weight=="mean"; A_clustered = A_clustered_mean; end
    if weight=="sum"; A_clustered = A_clustered_sum; end
    if weight=="min"; A_clustered = A_clustered_min; end
    if weight=="max"; A_clustered = A_clustered_max; end
    if weight=="binary"; A_clustered = A_clustered_binary; end
end

end