function [rege_dissimilarity_v]=regeTransform(rege_similarity)

%The ouput of UCINET is a similarity matrix. However, the Matlab function
%linkage takes only dissimilarity matrix. This is why it needs to be
%converted into a dissimilarity matrix. First, however, we need to
%normalise the similarity matrix.

n=length(rege_similarity);
rege_dissimilarity_m=zeros(n);

rege_similarity_normalised=rege_similarity/100;
for i=1:n
    for j=1:n
        rege_dissimilarity_m(i,j)=1-rege_similarity_normalised(i,j);
    end
end
rege_dissimilarity_v=squareform(rege_dissimilarity_m);

end