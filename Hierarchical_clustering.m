cd (uigetdir()) %Read the directory where the matrix files are stored 
Food_web={}; Cosi={}; Cosi_clust={}; Jacc={}; Jacc_clust={}; Ham={}; Ham_clust={}; Eucl={}; Eucl_clust={};  %Create the arrays

%HIERARCHICAL CLUSTERING FOR ALL THE FOOD WEB 
n=length(dir()) -2  %Set n as the number of matrix files
for x=1:n
Food_web{x}= xlsread(['Matrix_' num2str(x) '.xlsx']); %Import matrix without headers

Cosi{x} = pdist (Food_web{x},'cosine');
Cosi_clust{x} = linkage(Cosi{x});

Jacc{x} = pdist (Food_web{x},'jaccard');
Jacc_clust{x} = linkage(Jacc{x});

Ham{x} = pdist (Food_web{x},'hamming');
Ham_clust{x} = linkage(Ham{x});

Eucl{x} = pdist (Food_web{x}); %Proximity
Eucl_clust{x}= linkage(Eucl{x}); %Cluster
end

%VISUALISE WHAT YOU JUST DID
Food_web{1} %Check the original food web 
size(Food_web{1}) %Check the dimensions of the food web

A=table2array(Matrix_2)
size(A)
G=digraph()