nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
if nan_inf ~= 0
    A_clusters_DAG = createDAG(A_clusters);
    TP_clusters = calculateTP(A_clusters_DAG);
    nan_inf = sum(isinf(TP_clusters)) + sum(isnan(TP_clusters));
    if nan_inf ~= 0
        error("Problem with TP")
    end
end
