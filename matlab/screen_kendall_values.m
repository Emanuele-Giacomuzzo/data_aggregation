for clustering = 1:length(clustering_methods)
    for web = 1:tot_web_nr
        if length(A_ecobase{web}) > 1
            if sum(sum(isnan(kendalls{web,clustering}))) > 0 || sum(sum(isinf(kendalls{web,clustering}))) > 0
                "Nan/Inf in clustering " + clustering + " in food web " + web
            end
        end
        if sum(find(kendalls{web,clustering}==1)) > 0
            kendalls{web,clustering}(kendalls{web,clustering}==1) = 0.99;
            "τ = 1 in kendalls{" + web + "," + clustering + "} transformed into τ = 0.99.";
        end
    end
end

for bad_clustering = 1:length(row)
    kendalls{row(bad_clustering),col(bad_clustering)} = NaN;
end