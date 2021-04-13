kendalls_rearranged = cell(length(clustering_methods),1);
for clustering = 1:length(clustering_methods)
    kendalls_rearranged{clustering} = cell(length(centralities),length(linkage_n_strength));
end

for clustering = 1:length(clustering_methods)
    for centralityI = 1:length(centralities)
        for strength_n_ratio = 1:length(linkage_n_strength)
            for web = 1:tot_web_nr
                if length(kendalls{web,clustering}) > 1
                    kendalls_rearranged{clustering}{centralityI,strength_n_ratio} = [kendalls_rearranged{clustering}{centralityI,strength_n_ratio}; kendalls{web,clustering}(centralityI,strength_n_ratio)];
                end
            end
        end
    end
end
