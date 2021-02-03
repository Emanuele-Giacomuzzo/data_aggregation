function [A_clustered] = buildWeightedNetwork(A,A_clustered,membership,centrality_type,weight_method)

if (centrality_type=="nwDC" || centrality_type=="STO") 
    A_clustered_min=zeros(length(A_clustered));
    A_clustered_max=zeros(length(A_clustered));
    A_clustered_sum=zeros(length(A_clustered));
    A_clustered_mean=zeros(length(A_clustered));
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            MIN=10^10;
            MAX=0;
            SUM=0;
            COUNT=0;
            for k=1:length(A)
                for l=1:length(A)
                    if membership(k)==i && membership(l)==j && A(k,l)~=0 
                        if A(k,l)<MIN; MIN=A(k,l); end
                        if A(k,l)>MAX; MAX=A(k,l); end
                        SUM=SUM+A(k,l);
                        COUNT=COUNT+1;
                    end
                end
            end
            A_clustered_min(i,j)=MIN;
            A_clustered_max(i,j)=MAX;
            A_clustered_sum(i,j)=SUM;
            A_clustered_mean(i,j)=SUM/COUNT;
        end
    end
    if weight_method=="min"; A_clustered = A_clustered_min; end
    if weight_method=="mean"; A_clustered=A_clustered_mean; end
    if weight_method=="max"; A_clustered = A_clustered_max; end
    if weight_method=="sum"; A_clustered = A_clustered_sum; end
end


end