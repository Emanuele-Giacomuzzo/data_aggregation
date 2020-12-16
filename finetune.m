function[Q,s]=finetune(Q,B,s,m,z)

Q_v=zeros(length(s),1);
finetune_increase=1;

while finetune_increase>0
    for i=1:length(s)
        s(i)=s(i)*-1;
        Q_v(i)=(1/4*m)*s'*(B{z}+B{z}')*s;
        s(i)=s(i)*-1;
    end
    [max_Q,index]=max(Q_v,[],'all','linear'); finetune_increase=max_Q-Q;
    if finetune_increase>0
        s(index)=s(index)*-1;
        Q=max_Q;
    end
end

end