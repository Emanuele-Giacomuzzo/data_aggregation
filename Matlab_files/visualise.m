%Centrality heatmap
nDC_ratio=nDC/sum(nDC);
nwDC_ratio=nwDC/sum(nwDC);
nCC_ratio=nCC/sum(nCC);
nBC_ratio=nBC/sum(nBC);
s_ratio=s/sum(s);
cs_ratio=cs/sum(cs);
ns_ratio=ns/sum(ns);
k_ratio=k/sum(k);
kbu_ratio=kbu/sum(kbu);
ktd_ratio=ktd/sum(ktd);
kdir_ratio=kdir/sum(kdir);
kindir_ratio=kindir/sum(kindir);
TI_ratio=TI/sum(TI);
STO_ratio=STO/sum(STO);
TP_ratio=TP/sum(TP);
original_centralities=[nDC_ratio nwDC_ratio nCC_ratio nBC_ratio s_ratio cs_ratio ns_ratio k_ratio kbu_ratio ktd_ratio kdir_ratio kindir_ratio TI_ratio STO_ratio TP_ratio];
h2=heatmap(centralities,node_names,original_centralities,'Colormap',parula);
caxis(h2,[0, 1]);
h2.CellLabelFormat = '%.1f';
h2.Title="Centrality of the nodes inside the original network";

%Plot food webs
network_jaccard=digraph(A_clustered{1,1});
network_rege=digraph(A_clustered{1,2});
network_pattern_modul=digraph(A_clustered{1,3});
network_density_modul=digraph(A_clustered{1,4});
network_groups=digraph(A_clustered{1,5});
plot(network, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_jaccard, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_rege, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_pattern_modul, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_density_modul, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');
plot(network_groups, 'layout', 'layered', 'direction', 'up', 'nodecolor', 'k');

%Heatmap
h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";