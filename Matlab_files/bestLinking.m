function [best_link,best_weight] = bestLinking(A,cluster_ID,centrality_type,centrality_original)

best_W=0;
best_weight="binary";
weight_type = ["min" "mean" "max" "sum"];
A_clustered=double.empty;
for threshold=1:1:100
    for i=1:length(weight_type)
        weight = weight_type(i);
        %Build the binary network according to threshold
        cluster_size = clusterSize(cluster_ID);
        possible_connections = possibleConnections(cluster_size);
        realised_connections = realisedConnections(tounweighted(A),cluster_ID);
        for i=1:max(cluster_ID) 
            for j=1:max(cluster_ID)
                if realised_connections(i,j)/possible_connections(i,j)*100>threshold
                    A_clustered(i,j)=1;
                end
            end
        end
        %Build the weighted network according to threshold and strength
        %method
        if centrality_type=="nwDC" || centrality_type=="STO"
            A_clustered_min=zeros(length(A_clustered));
            A_clustered_mean=zeros(length(A_clustered));
            A_clustered_max=zeros(length(A_clustered));
            A_clustered_sum=zeros(length(A_clustered));
            for i=1:length(A_clustered)
                for j=1:length(A_clustered)
                    if A_clustered(i,j)==1
                        COUNT=0;
                        SUM=0;
                        MAX=0;
                        MIN=10^10;
                        for k=1:length(A)
                            for l=1:length(A)
                                if cluster_ID(k) == i && cluster_ID(l) == j
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
        end
        if weight=="mean"; A_clustered = A_clustered_mean; end
        if weight=="sum"; A_clustered = A_clustered_sum; end
        if weight=="min"; A_clustered = A_clustered_min; end
        if weight=="max"; A_clustered = A_clustered_max; end
        %Calculate centrality
        centrality_clusters=centralityClusters(A_clustered,centrality_type); 
        centrality_nodes=centralityNodes(centrality_clusters, cluster_ID);
        centrality_compare=[centrality_original, centrality_nodes];
        W = KendallCoef(centrality_compare);
        if W > best_W 
            best_W=W;
            best_link=i;
            best_weight=weight;
        end
    end
end

end