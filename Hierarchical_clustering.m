pkg load 'io'
pkg load 'statistics'

%HIERARCHICAL CLUSTERING FOR ALL THE FOOD WEB 
cd (uigetdir()) %Read the directory where the matrix files are stored 
n=length(dir()) -2  %Set n as the number of matrix files
Cosi={}; Cosi_clust={}; Jacc={}; Jacc_clust={}; Ham={}; Ham_clust={}; Eucl={}; Eucl_clust={};  %Create the arrays
for x=1:n
Matrix= xlsread(['Matrix_' num2str(x) '.xlsx']); %Import matrix without headers

Cosi{x} = pdist (Matrix,'cosine');
Cosi_clust{x} = linkage(Cosi{x});

Jacc{x} = pdist (Matrix,'jaccard');
Jacc_clust{x} = linkage(Jacc{x});

Ham{x} = pdist (Matrix,'hamming');
Ham_clust{x} = linkage(Ham{x});

Eucl{x} = pdist (Matrix); %Proximity
Eucl_clust{x}= linkage(Eucl{x}); %Cluster
end