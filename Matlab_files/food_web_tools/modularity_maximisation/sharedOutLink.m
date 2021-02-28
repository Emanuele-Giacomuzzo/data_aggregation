function [shared_outgoing] = sharedOutLink(adj_dir_binary)

shared_outgoing=zeros(length(adj_dir_binary));

for i=1:length(adj_dir_binary)
    for j=1:length(adj_dir_binary)
        for k=1:length(adj_dir_binary)
            if (adj_dir_binary(i,k)) && (adj_dir_binary(j,k))
                shared_outgoing(i,j)=shared_outgoing(i,j)+1;
            end
        end
    end
end

end