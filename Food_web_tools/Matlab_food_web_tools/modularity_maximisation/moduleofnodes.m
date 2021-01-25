function [module_of_nodes] = moduleofnodes(modules)

module_of_nodes=zeros(max(modules{1}),1);

for i=1:length(module_of_nodes)
    for n=1:length(modules)
        if modules{n}(i)==i
            module_of_nodes(i)=n;
        end
    end
end

end