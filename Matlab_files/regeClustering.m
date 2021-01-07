function[cluster_identity_rege]=regeClustering(REGE, threshold, link_percentage)

%Watch out: this toolbox doesn't implement the REGE algorithm. It needs to
%be calcualated from the UCINET VI software (available only for windows at
%https://sites.google.com/site/ucinetsoftware/home). The output of UCINET
%needs then to be transformed into a matlab matrix and saved in the folder
%data. Here I supposed that the maximum of REGE is 1000. 

cd rege_clustering;

REGE_norm=REGE/1000;
REGE_dis=similarityToDissimilarity(REGE_norm);

rege_v=squareform(REGE_dis);
rege_average = linkage(rege_v, 'average');
cluster_identity_rege =cluster(rege_average,'cutoff',threshold);

cd ..;

end