function[modules,B]=createmodulesandb(A_db)

for i=1:(length(A_db)*2)
    if i==1
        for i=1:length(A_db) 
            modules{1}(i,1)=i; 
        end
    else
    modules{i}=zeros(length(A_db),1);
    end
end

for i=1:(length(A_db)*2)
    B{i}=zeros(length(A_db)); 
end

end