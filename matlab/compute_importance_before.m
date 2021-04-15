WDC_before = calculateWDC(A_ecobase{chosen_web});
importance_before = repmat("not important", length(WDC_before), 1);
[~,keystone] = max(WDC_before);
importance_before(keystone) = "important";