rege_similarity=REGE3;
for i=1:2
if i==1; similarity="jaccard"; elseif i==2; similarity="rege"; end
[clusterID_nDC(:,i),A_nDC{i},nDC(:,i+1)] = hierarchicalClustering(A,similarity,"nDC",nDC(:,1),rege_similarity);
[clusterID_nwDC(:,i),A_nwDC{i},nwDC(:,i+1)] = hierarchicalClustering(A,similarity,"nwDC",nwDC(:,1),rege_similarity);
[clusterID_nCC(:,i),A_nCC{i},nCC(:,i+1)] = hierarchicalClustering(A,similarity,"nCC",nCC(:,1),rege_similarity);
[clusterID_nBC(:,i),A_nBC{i},nBC(:,i+1)] = hierarchicalClustering(A,similarity,"nBC",nBC(:,1),rege_similarity);
[clusterID_s(:,i),A_s{i},s(:,i+1)] = hierarchicalClustering(A,similarity,"s",s(:,1),rege_similarity);
[clusterID_cs(:,i),A_cs{i},cs(:,i+1)] = hierarchicalClustering(A,similarity,"cs",cs(:,1),rege_similarity);
[clusterID_ns(:,i),A_ns{i},ns(:,i+1)] = hierarchicalClustering(A,similarity,"ns",ns(:,1),rege_similarity);
[clusterID_k(:,i),A_k{i},k(:,i+1)] = hierarchicalClustering(A,similarity,"k",k(:,1),rege_similarity);
[clusterID_kbu(:,i),A_kbu{i},kbu(:,i+1)] = hierarchicalClustering(A,similarity,"kbu",kbu(:,1),rege_similarity);
[clusterID_ktd(:,i),A_ktd{i},ktd(:,i+1)] = hierarchicalClustering(A,similarity,"ktd",ktd(:,1),rege_similarity);
[clusterID_kdir(:,i),A_kdir{i},kdir(:,i+1)] = hierarchicalClustering(A,similarity,"kdir",kdir(:,1),rege_similarity);
[clusterID_kindir(:,i),A_kindir{i},kindir(:,i+1)] = hierarchicalClustering(A,similarity,"kindir",kindir(:,1),rege_similarity);
[clusterID_TI(:,i),A_TI{i},TI(:,i+1)] = hierarchicalClustering(A,similarity,"TI",TI(:,1),rege_similarity);
[clusterID_TIratio(:,i),A_TIratio{i},TIratio(:,i+1)] = hierarchicalClustering(A,similarity,"TI_ratio",TI_ratio(:,1),rege_similarity);
[clusterID_TO(:,i),A_TO{i},TO(:,i+1)] = hierarchicalClustering(A,similarity,"TO",TO(:,1),rege_similarity);
[clusterID_TOratio(:,i),A_TOratio{i},TOratio(:,i+1)] = hierarchicalClustering(A,similarity,"TO_ratio",TO_ratio(:,1),rege_similarity);
end

for i=3:5
if i==3; clustering_type="pattern_modularity"; elseif i==4; clustering_type="density_modularity"; elseif i==5; clustering_type="group_model"; end
if i==3; clusterID=clusterID_patternModularity; elseif i==4; clusterID=clusterID_densityModularity; elseif i==5; clusterID=clusterID_groups; end
[A_nDC{i},nDC(:,i+1)] = otherClustering(A,clustering_type,"nDC",nDC,clusterID);
[A_nwDC{i},nwDC(:,i+1)] = otherClustering(A,clustering_type,"nwDC",nwDC,clusterID);
[A_nCC{i},nCC(:,i+1)] = otherClustering(A,clustering_type,"nCC",nCC,clusterID);
[A_nBC{i},nBC(:,i+1)] = otherClustering(A,clustering_type,"nBC",nBC,clusterID);
[A_s{i},s(:,i+1)] = otherClustering(A,clustering_type,"s",s,clusterID);
[A_cs{i},cs(:,i+1)] = otherClustering(A,clustering_type,"cs",cs,clusterID);
[A_ns{i},ns(:,i+1)] = otherClustering(A,clustering_type,"ns",ns,clusterID);
[A_k{i},k(:,i+1)] = otherClustering(A,clustering_type,"k",k,clusterID);
[A_kbu{i},kbu(:,i+1)] = otherClustering(A,clustering_type,"kbu",kbu,clusterID);
[A_ktd{i},ktd(:,i+1)] = otherClustering(A,clustering_type,"ktd",ktd,clusterID);
[A_kdir{i},kdir(:,i+1)] = otherClustering(A,clustering_type,"kdir",kdir,clusterID);
[A_kindir{i},kindir(:,i+1)] = otherClustering(A,clustering_type,"kindir",kindir,clusterID);
[A_TI{i},TI(:,i+1)] = otherClustering(A,clustering_type,"TI",TI,clusterID);
[A_TIratio{i},TIratio(:,i+1)] = otherClustering(A,clustering_type,"TI_ratio",TI_ratio,clusterID);
[A_TO{i},TO(:,i+1)] = otherClustering(A,clustering_type,"TO",TO,clusterID);
[A_TOratio{i},TOratio(:,i+1)] = otherClustering(A,clustering_type,"TO_ratio",TO_ratio,clusterID);
end


%%%%

clusterID_patternModularity=patternModularity(A);
clusterID_densityModularity=densityModularity(A);