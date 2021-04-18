# Data aggregation 

This is the code and the data we used during the analysis we performed in Giacomuzzo & Jordán (2021).

## Data
We used 76 food webs built through the Ecopath with Ecosim methodology. You can find the food webs we used in our study in Table S1 of the supporting information of Heymans et al. (2014) (https://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0095845.s001). Watch out: the enumeration is not the same. Check the data folder for the conversion between our enumeration and their enumeration. Also, we used only 76 food webs out of their 105.

## Work flow
The main analysis is carried out in MATLAB. However, certain functions were not available in MATLAB, so we used it in combination with R, UCINET and C.

1. Compute the membership of the different species to different groups through the signed group model of Sander et al. (2015) (https://github.com/elsander/SignedGroupModel). Save them into results/membership_group_model.
2. Compute the REGE matrices through UCINET (https://sites.google.com/site/ucinetsoftware/home). You need to import into UCINET the matrices found at data/adjacency_matrices_ucinet. Save them into results/REGE_matrices.
3. Run r/main_1
4. Run matlab/main
5. Run r/main_2

## Dependencies
1. Food Web Analysis Toolbox (https://uk.mathworks.com/matlabcentral/fileexchange/89907-food-web-analysis-toolbox)
2. Netcarto R package (https://cran.r-project.org/web/packages/rnetcarto/vignettes/getting-started.html)

## References
Heymans, J. J., Coll, M., Libralato, S., Morissette, L., & Christensen, V. (2014). Global patterns in ecological indicators of marine food webs: a modelling approach. PloS one, 9(4), e95845.
Sander, E. L., Wootton, J. T., & Allesina, S. (2015). What can interaction webs tell us about species roles?. PLoS computational biology, 11(7), e1004330.