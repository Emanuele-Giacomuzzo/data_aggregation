function [dissimilarity] = similarityToDissimilarity(similarity)

n=length(similarity);
dissimilarity=zeros(n);

for i=1:n
    for j=1:n
        dissimilarity(i,j)=1-similarity(i,j);
    end
end

end