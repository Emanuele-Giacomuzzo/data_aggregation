function[modules]=modulecomposition(s,even)

a=0;b=0;
modules=zeros(length(s),1);

for i=1:length(s)
    if s(i)==1
        a=1;
    elseif s(i)==-1
        b=1;
    end
end

if (a>0) && (b>0)
    if even==1
        for i=1:length(s)
            if s(i)==1
                modules(i,1)=i;
            else
                modules(i,1)=0;
            end
        end
    end
    if even==0
        for i=1:length(s)
            if s(i)==-1
                modules(i,1)=i;
            else
                modules(i,1)=0;
            end
        end
    end
end

end