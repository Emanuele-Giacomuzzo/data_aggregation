function [node_overlap_v] = topological_overlap(adj_weighted, threshold)
threshold=0.1;
%n-step matrices
n_step{1}=adj_weighted;
for n=2:10
n_step{n}=n_step{n-1}.^n;
end

%average effect matrix
addition=adj_weighted;
for n=1:10
    addition=addition+n_step{n};
end
average_effect=(1/n)*addition;

%interactor matrix
for i=1:length(adj_weighted)
    for j=1:length(adj_weighted)
        if average_effect(i,j) > threshold
            interactor(i,j)='S';
        else
            interactor(i,j)='W';
        end
    end
end

%topological overlap matrix
s=0;
for c=1:length(interactor)
    for d=1:length(interactor)
        for r=1:length(interactor)
        if interactor(r,c)=='S'
            if interactor(r,d)=='S'
                node_overlap_m(c,d)=s+1;
            else 
                node_overlap_m(c,d)=0;
            end
        else node_overlap_m(c,d)=0;
        end
        end
    end
end

%topological overlap vector
node_overlap_v=sum(node_overlap_m);