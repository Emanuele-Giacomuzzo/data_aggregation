function[ edgelist ]=edgelistBinary( A )

edgelist = double.empty; 

for i=1:length(A)
    for j=1:length(A)
        if A(i,j) ~= 0
            edgelist = [edgelist; i j];
        end
    end
end

end