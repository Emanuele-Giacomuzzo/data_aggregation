for web = 1:tot_web_nr
    if length(A_ecobase{web}) > 1
        
        if exist('chosen_web','var') == 1
            web = chosen_web;
        end
        
        A = A_ecobase{web};
        A_DAG = createDAG(A);

        find_membership_of_Jaccard;
        find_membership_of_REGE;
        calculate_original_centralities;
        calculate_the_realised_link_ratios;
        calculate_n_save_kendalls;
    else
        save_empty_kendalls_n_memberships;
    end
    
    if exist('chosen_web','var') == 1
        break
    end
    
end