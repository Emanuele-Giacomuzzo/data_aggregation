function[centrality_clusters]=calculateCentrality(centrality)

if centrality=="degree" centrality_clusters=centrality(network_und,'degree')/(n-1); end
if centrality=="betweenness" centrality_clusters=centrality(network_dir,'betweenness')/[(n-1)*(n-2)/2]; end
if centrality=="closeness" centrality_clusters=centrality(network_und,'closeness')*(n-1); end
if centrality=="TI" [centrality_clusters,TI_species_ratio]=topologicalImportance(adj_und_binary,3); end
if centrality=="TI ratio" [TI_species,centrality_clusters]=topologicalImportance(adj_und_binary,3); end
if centrality=="status" [centrality_clusters,controstatus,net_status] = status_index(network_dir); end
if centrality=="controstatus" [status,centrality_clusters,net_status] = status_index(network_dir); end
if centrality=="net_status" [status,controstatus,centrality_clusters] = status_index(network_dir); end
if centrality=="keystone" [centrality_clusters,kbu,ktd,kdir,kindir]=keystoneIndices(adj_dir_binary); end
if centrality=="keystone bu" [k,centrality_clusters,ktd,kdir,kindir]=keystoneIndices(adj_dir_binary); end
if centrality=="keystone td" [k,kbu,centrality_clusters,kdir,kindir]=keystoneIndices(adj_dir_binary); end
if centrality=="keystone dir " [k,kbu,ktd,centrality_clusters,kindir]=keystoneIndices(adj_dir_binary); end
if centrality=="keystone indir" [k,kbu,ktd,kdir,centrality_clusters]=keystoneIndices(adj_dir_binary); end
if centrality=="TO" [centrality_clusters,overlap_ratio]=topologicalOverlap(adj_und_binary,adj_dir_weight,network_und,3,0.01); end
if centrality=="TO ratio" [overlap,centrality_clusters]=topologicalOverlap(adj_und_binary,adj_dir_weight,network_und,3,0.01); end
if centrality=="STO" end %where's uniqueness?

end