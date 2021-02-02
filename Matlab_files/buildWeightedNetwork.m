function [A_clustered] = buildWeightedNetwork(A,A_clustered,membership,centrality_type,weight_method)

if (centrality_type=="nwDC" || centrality_type=="STO") && weight_method=="min"
    A_clustered_min=zeros(length(A_clustered));
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            MIN=10^10;
            for k=1:length(A)
                for l=1:length(A)
                    if membership(k)==i && membership(l)==j && A(k,l)~=0 && A(k,l)<MIN
                        MIN=A(k,l);
                    end
                end
            end
            A_clustered_min(i,j)=MIN;
        end
        A_clustered = A_clustered_min;
    end
end

if (centrality_type=="nwDC" || centrality_type=="STO") && weight_method=="mean"
    A_clustered_mean=zeros(length(A_clustered));
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            COUNT=0;
            SUM=0;
            for k=1:length(A)
                for l=1:length(A)
                    if membership(k)==i && membership(l)==j && A(k,l)~=0
                        COUNT=COUNT+1;
                        SUM=SUM+A(k,l);
                    end
                end
            end
            A_clustered_mean(i,j)=SUM/COUNT;
        end
    end
    A_clustered=A_clustered_mean;
end

if (centrality_type=="nwDC" || centrality_type=="STO") && weight_method=="max"
    A_clustered_max=zeros(length(A_clustered));
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            MAX=0;
            for k=1:length(A)
                for l=1:length(A)
                    if membership(k)==i && membership(l)==j && A(k,l)~=0 && A(k,l)>MAX
                        MAX=A(k,l);
                    end
                end
            end
            A_clustered_max(i,j)=MAX;
        end
        A_clustered = A_clustered_max;
    end
end

if (centrality_type=="nwDC" || centrality_type=="STO") && weight_method=="sum"
    A_clustered_sum=zeros(length(A_clustered));
    for i=1:length(A_clustered)
        for j=1:length(A_clustered)
            SUM=0;
            for k=1:length(A)
                for l=1:length(A)
                    if membership(k)==i && membership(l)==j && A(k,l)~=0
                        SUM=SUM+A(k,l);
                    end
                end
            end
        end
        A_clustered = A_clustered_sum;
    end
end

end