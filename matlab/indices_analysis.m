for web = 1:tot_web_nr
    if length(A_ecobase{web}) > 1
        
        if exist('chosen_web','var') == 1
            web = chosen_web;
        end
        
        A = A_ecobase{web};
        A_DAG = createDAG(A);

        branches_jaccard = findBranches(A,"jaccard");
        membership{web,1} = cluster(branches_jaccard,'cutoff',hc_max_inconsistency);
        path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt';
        writematrix(membership{web,1}, path);
        branches_rege = findBranches(A,"rege",REGE_matrices{web});
        membership{web,2} = cluster(branches_rege,'cutoff',hc_max_inconsistency); 
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt';
        writematrix(membership{web,2}, path);

        DC = centrality(graph(toundirected(A)),'degree');
        WDC = calculateWDC(A);
        CC = centrality(graph(toundirected(A)),'closeness');
        BC = centrality(digraph(A),'betweenness');
        [s,cs,ns] = calculateStatus(A_DAG);
        [kindex,kbu,ktd,kdir,kindir] = calculateKeystone(A_DAG);
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

        realised_link_ratio = cell(length(clustering_methods),1);
        for clustering = 1:length(clustering_methods)
            cluster_size = findClusterSize(membership{web,clustering});
            possible_links = findPossibleLinks(cluster_size);
            realised_links = findRealisedLinks(A,membership{web,clustering});
            realised_link_ratio{clustering} = findRealisedLinkRatio(possible_links, realised_links);
        end

        for clustering = 1:length(clustering_methods)
            for centr = 1:length(centralities)
                column = 0;
                for linkage = 1:length(linkage_methods)
                    for strength = 1:length(strength_methods)
                        column = column + 1;
                        A_aggregated_weighted = buildWeightedNetwork(A, membership{web,clustering}, strength_methods(strength));
                        A_aggregated_binary = buildBinaryNetwork(realised_link_ratio{clustering}, linkage_methods(linkage));
                        A_aggregated{web}{clustering,column} = A_aggregated_weighted .* A_aggregated_binary;
                        centrality_clusters = calculateClusterCentrality(A_aggregated{web}{clustering,column}, centralities(centr));
                        centrality_nodes = assignNodeCentrality(centrality_clusters, membership{web,clustering});
                        Kendalls{web}{clustering}(centr, column) = calculateKendall([centralities_original(:,centr) centrality_nodes']);
                    end
                end
            end
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
            writematrix(Kendalls{web}{clustering}, path);
        end
    else
        for clustering = 1:length(clustering_methods)
            path = '/Users/ema/github/data_aggregation/results/kendalls_' + clustering_methods(clustering) + '/' + "Kendalls_" + clustering_methods(clustering) + addFrontZeros(web) + ".txt";
            writematrix(A_ecobase{web}, path);
        end
        path = '/Users/ema/github/data_aggregation/results/membership_jaccard_similarity/membership_jaccard_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
        path = '/Users/ema/github/data_aggregation/results/membership_rege_similarity/membership_rege_' + addFrontZeros(web) + '.txt'
        writematrix(A_ecobase{web}, path);
    end
    
    if exist('chosen_web','var') == 1
        break
    end
    
end