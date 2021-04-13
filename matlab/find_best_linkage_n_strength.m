[~,best_strength_n_links] = max(kendalls{chosen_web,clustering}(chosen_importance,:));
if clustering == 3
    best_strength_n_links = 2;
end