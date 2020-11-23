function [node_topological_overlaps] = topological_overlap(weighted_network, threshold)

%n-step matrices
A{1}=weighted_network;
for n=2:10
A{n}=A{n-1}.^n;
end

%average effect matrix
sum=weighted_network;
for n=2:10
    sum=sum+A{n}
end
E=(1/n)*sum;

%interactor matrix
for i=1:length(weighted_network)
    for j=1:length(weighted_network)
        if E(i,j) > threshold
            interactor(

            
     
end