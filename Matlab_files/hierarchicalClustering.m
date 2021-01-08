function [cluster_nr,adj] = hierarchicalClustering(similarity,centrality,similarity_matrix)
%Watch out: this toolbox doesn't implement the REGE algorithm. It needs to
%be calculated from the UCINET VI software (available only for windows at
%https://sites.google.com/site/ucinetsoftware/home). The output of UCINET
%needs then to be transformed into a matlab matrix and saved in the folder
%data. Here I supposed that the maximum of REGE is 1000.
cd hierarchical_clustering;

if similarity=="jaccard"
    dissimilarity = pdist (adj_dir_binary, 'jaccard');
elseif similarity=="rege" 
    dissimilarity = regeTransform(similarity_matrix);
end

best_linkage = chooseLinkageCriteria(dissimilarity);
linked = linkWithBestCriteria(best_linkage,dissimilarity);
[cluster_nr,adj] = bestClustering(adj_dir_binary,degree,jaccard_v,jaccard_linked); %wired

cd ..;
end

%Example
%similarity=rege
%centrality=degree
%similarity_matrix=REGE3