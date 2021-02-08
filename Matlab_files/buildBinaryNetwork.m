function [A_clustered] = buildBinaryNetwork(realised_ratio,ratio)

n=length(realised_ratio);
A_clustered=zeros(n);
for i=1:n
    for j=1:n
        if realised_ratio(i,j)>ratio
            A_clustered(i,j)=1;
        end
    end
end

end