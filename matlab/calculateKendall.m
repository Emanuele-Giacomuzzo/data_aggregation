function Kendall = Kendallcorrelation(rankings)
    Kendall_matrix = corr(rankings,'Type','Kendall');
    Kendall_matrix(isinf(Kendall_matrix)|isnan(Kendall_matrix)) = 0;
    Kendall = min(min(Kendall_matrix));
end