%Best parameters 
heatmap(best_percentage);
best_weight 
%Food webs
n=1;
m=1;
plot(digraph(A_clustered{m,n}));
m=m+1;
n=n+1;
%New centrality indices 
heatmap(nDC);
heatmap(nwDC); 
heatmap(nCC);
heatmap(nBC);
heatmap(s);
heatmap(cs);
heatmap(ns);
heatmap(kindex);
heatmap(kbu);
heatmap(ktd);
heatmap(kdir);
heatmap(kindir);
heatmap(TI);
heatmap(STO);
heatmap(TP);
%Correlations
z=heatmap(aggregations,centralities,best_ICC);
z.CellLabelFormat = '%.2f';

%Centrality heatmap
nDC_ratio=nDC./sum(nDC);
nwDC_ratio=nwDC./sum(nwDC);
nCC_ratio=nCC./sum(nCC);
nBC_ratio=nBC./sum(nBC);
s_ratio=s./sum(s);
cs_ratio=cs./sum(cs);
ns_ratio=ns./sum(ns);
kindex_ratio=kindex./sum(kindex);
kbu_ratio=kbu./sum(kbu);
ktd_ratio=ktd./sum(ktd);
kdir_ratio=kdir./sum(kdir);
kindir_ratio=kindir./sum(kindir);
TI_ratio=TI./sum(TI);
STO_ratio=STO./sum(STO);
TP_ratio=TP./sum(TP);
original_centralities=[nDC_ratio nwDC_ratio nCC_ratio nBC_ratio s_ratio cs_ratio ns_ratio kindex_ratio kbu_ratio ktd_ratio kdir_ratio kindir_ratio TI_ratio STO_ratio TP_ratio];
h2=heatmap(centralities,node_names,centralities_original,'Colormap',parula);
caxis(h2,[0, 1]);
h2.CellLabelFormat = '%.1f';
h2.Title="Centrality of the nodes inside the original network";

%Heatmap
h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";