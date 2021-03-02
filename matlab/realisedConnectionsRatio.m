function [realised_ratio] = realisedConnectionsRatio(possible,realised)

n=length(possible);
realised_ratio=zeros(n);
for i=1:n
    for j=1:n
        realised_ratio(i,j)=realised(i,j)/possible(i,j);
    end
end

end