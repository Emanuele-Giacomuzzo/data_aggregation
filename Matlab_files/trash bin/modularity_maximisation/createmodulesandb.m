function[modules,B]=createmodulesandb(adj_dir_binary)

for i=1:(length(adj_dir_binary)*2)
    if i==1
        for i=1:length(adj_dir_binary) 
            modules{1}(i,1)=i; 
        end
    else
    modules{i}=zeros(length(adj_dir_binary),1); 
    end
end

for i=1:(length(adj_dir_binary)*2)
    B{i}=zeros(length(adj_dir_binary)); 
end

end