WDC_after_clusters = calculateWDC(A_clusters);
importance_after_clusters = repmat("not important", length(A_clusters),1);
[~,keystone] = max(WDC_after_clusters);
importance_after_clusters(keystone) = "important";
importance_after_nodes = (assignNodeCentrality(importance_after_clusters, membership{chosen_web,clustering}))';
