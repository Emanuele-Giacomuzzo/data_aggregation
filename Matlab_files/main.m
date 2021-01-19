%Running time: 2m40sec. A needs to be directed and weighted. Rege needs to
%be computed with the software UCINET. The clusterID of the group model
%needs to be computed through the C program. 
clc,clear; cd '/Users/ema/Google Drive/Github/Data_aggregation/Matlab_files';
rege_similarity=readmatrix("../data/REGE3");
A=readmatrix("../data/adjacency_matrix.txt");
network=digraph(A);
network_U=graph(toundirected(A));
n=length(A);

clusterID_patternModularity=patternModularity(A);
clusterID_densityModularity=densityModularity(A);
clusterID_groups=readmatrix("../data/group_model_results");

centralities=["nDC";"nwDC";"nCC";"nBC";"s";"cs";"ns";"k";"kbu";"ktd";"kdir";"kindir";"TI";"STO";"TP"];
c=length(centralities);
aggregations=["Jaccard similarity HC";"Rege similarity HC";"Pattern modularity";"Density modularity";"Group model"];
a=length(aggregations);


[nDC,nwDC,nCC,nBC,s,cs,ns,k,kbu,ktd,kdir,kindir,TI,STO,TP] = initialiseCentrality(a,n);
[A_nDC,A_nwDC,A_nCC,A_nBC,A_s,A_cs,A_ns,A_k,A_kbu,A_ktd,A_kdir,A_kindir,A_TI,A_STO,A_TP] = initialiseA(n,a);
[clusterID_nDC,clusterID_nwDC,clusterID_nCC,clusterID_nBC,clusterID_s,clusterID_cs,clusterID_ns,clusterID_k,clusterID_kbu,clusterID_ktd,clusterID_kdir,clusterID_kindir,clusterID_TI,clusterID_STO,clusterID_TP] = initialiseClusterID(n,a);
for i=1:6
    if i==1
        nDC(:,1) = centrality(network_U,'degree')/(n-1);
        nwDC(:,1) = weightedDegree(A)/(n-1);
        nCC(:,1) = centrality(network_U,'closeness')*(n-1);
        nBC(:,1) = centrality(network,'betweenness')/((n-1)*(n-2)/2);
        [s(:,1),cs(:,1),ns(:,1)] = statusIndices(A); 
        [k(:,1),kbu(:,1),ktd(:,1),kdir(:,1),kindir(:,1)] = keystoneIndices(A);
        [TI(:,1),TI_ratio(:,1)] = topologicalImportance(A,3);
        [STO(:,1),STO_ratio(:,1)] = topologicalOverlap(A,3,0.02,0.2,0.02);
        TP(:,1) = trophicPosition(A);
    end
    if i==2 || i==3
        if i==2; similarity="jaccard"; elseif i==3; similarity="rege"; end
        [clusterID_nDC(:,i-1),A_nDC{i},nDC(:,i),best_th(1,i-1),best_link(1,i-1)] = hierarchicalClustering(A,similarity,"nDC",nDC(:,1),rege_similarity);
        [clusterID_nwDC(:,i-1),A_nwDC{i},nwDC(:,i),best_th(2,i-1),best_link(2,i-1)] = hierarchicalClustering(A,similarity,"nwDC",nwDC(:,1),rege_similarity);
        [clusterID_nCC(:,i-1),A_nCC{i},nCC(:,i),best_th(3,i-1),best_link(3,i-1)] = hierarchicalClustering(A,similarity,"nCC",nCC(:,1),rege_similarity);
        [clusterID_nBC(:,i-1),A_nBC{i},nBC(:,i),best_th(4,i-1),best_link(4,i-1)] = hierarchicalClustering(A,similarity,"nBC",nBC(:,1),rege_similarity);
        [clusterID_s(:,i-1),A_s{i},s(:,i),best_th(5,i-1),best_link(5,i-1)] = hierarchicalClustering(A,similarity,"s",s(:,1),rege_similarity);
        [clusterID_cs(:,i-1),A_cs{i},cs(:,i),best_th(6,i-1),best_link(6,i-1)] = hierarchicalClustering(A,similarity,"cs",cs(:,1),rege_similarity);
        [clusterID_ns(:,i-1),A_ns{i},ns(:,i),best_th(7,i-1),best_link(7,i-1)] = hierarchicalClustering(A,similarity,"ns",ns(:,1),rege_similarity);
        [clusterID_k(:,i-1),A_k{i},k(:,i),best_th(8,i-1),best_link(8,i-1)] = hierarchicalClustering(A,similarity,"k",k(:,1),rege_similarity);
        [clusterID_kbu(:,i-1),A_kbu{i},kbu(:,i),best_th(9,i-1),best_link(9,i-1)] = hierarchicalClustering(A,similarity,"kbu",kbu(:,1),rege_similarity);
        [clusterID_ktd(:,i-1),A_ktd{i},ktd(:,i),best_th(10,i-1),best_link(10,i-1)] = hierarchicalClustering(A,similarity,"ktd",ktd(:,1),rege_similarity);
        [clusterID_kdir(:,i-1),A_kdir{i},kdir(:,i),best_th(11,i-1),best_link(11,i-1)] = hierarchicalClustering(A,similarity,"kdir",kdir(:,1),rege_similarity);
        [clusterID_kindir(:,i-1),A_kindir{i},kindir(:,i),best_th(12,i-1),best_link(12,i-1)] = hierarchicalClustering(A,similarity,"kindir",kindir(:,1),rege_similarity);
        [clusterID_TI(:,i-1),A_TI{i},TI(:,i),best_th(13,i-1),best_link(13,i-1)] = hierarchicalClustering(A,similarity,"TI",TI(:,1),rege_similarity);
        [clusterID_STO(:,i-1),A_STO{i},STO(:,i),best_th(14,i-1),best_link(14,i-1)] = hierarchicalClustering(A,similarity,"STO",STO(:,1),rege_similarity); 
        [clusterID_TP(:,i-1),A_TP{i},TP(:,i),best_th(15,i-1),best_link(15,i-1)] = hierarchicalClustering(A,similarity,"TP",TP(:,1),rege_similarity); 
    end
    if i==4 || i==5 || i==6
        if i==4; clustering_type="pattern_modularity"; elseif i==5; clustering_type="density_modularity"; elseif i==6; clustering_type="group_model"; end
        if i==4; clusterID=clusterID_patternModularity; elseif i==5; clusterID=clusterID_densityModularity; elseif i==6; clusterID=clusterID_groups; end
        [A_nDC{i},nDC(:,i),best_link(:,i-1)] = otherClustering(A,"nDC",nDC,clusterID);
        [A_nwDC{i},nwDC(:,i),best_link(:,i-1)] = otherClustering(A,"nwDC",nwDC,clusterID);
        [A_nCC{i},nCC(:,i),best_link(:,i-1)] = otherClustering(A,"nCC",nCC,clusterID);
        [A_nBC{i},nBC(:,i),best_link(:,i-1)] = otherClustering(A,"nBC",nBC,clusterID);
        [A_s{i},s(:,i),best_link(:,i-1)] = otherClustering(A,"s",s,clusterID);
        [A_cs{i},cs(:,i),best_link(:,i-1)] = otherClustering(A,"cs",cs,clusterID);
        [A_ns{i},ns(:,i),best_link(:,i-1)] = otherClustering(A,"ns",ns,clusterID);
        [A_k{i},k(:,i),best_link(:,i-1)] = otherClustering(A,"k",k,clusterID);
        [A_kbu{i},kbu(:,i),best_link(:,i-1)] = otherClustering(A,"kbu",kbu,clusterID);
        [A_ktd{i},ktd(:,i),best_link(:,i-1)] = otherClustering(A,"ktd",ktd,clusterID);
        [A_kdir{i},kdir(:,i),best_link(:,i-1)] = otherClustering(A,"kdir",kdir,clusterID);
        [A_kindir{i},kindir(:,i),best_link(:,i-1)] = otherClustering(A,"kindir",kindir,clusterID);
        [A_TI{i},TI(:,i),best_link(:,i-1)] = otherClustering(A,"TI",TI,clusterID);
        [A_STO{i},STO(:,i),best_link(:,i-1)] = otherClustering(A,"STO",STO,clusterID);
        [A_TP{i},TP(:,i),best_link(:,i-1)] = otherClustering(A,"TP",TP,clusterID); %problem 
    end
end

W=zeros(c,5);
for i=1:c
    centrality_type=eval(centralities(i));
    for j=2:6
        centralities_to_check=[centrality_type(:,1) centrality_type(:,j)]; %here
        W(i,j-1)=KendallCoef(centralities_to_check);
    end
end
rs=((a*W)-1)/(a-1);

h=heatmap(aggregations,centralities,rs,'Colormap',parula);
h.CellLabelFormat = '%.2f';
h.Title="Spearman’s correlation coefficients";
%Tounweighted changes the network if the input is already unweighted. The toundirected actually works real fine.