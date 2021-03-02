function[module_number_new]=changemodulenumber(cluster_identity_mod_den)

module_number_unique=unique(cluster_identity_mod_den); %Good until here
module_number_new=zeros(length(cluster_identity_mod_den),1);

for i=1:length(cluster_identity_mod_den)
    module_number_new(i)=find(module_number_unique==cluster_identity_mod_den(i));
end

end