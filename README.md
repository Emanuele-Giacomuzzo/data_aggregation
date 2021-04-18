# Data aggregation 

This is the code and the data we used during the analysis we performed in Giacomuzzo & Jordán (2021).

## Data
We used 76 food webs built through the Ecopath with Ecosim methodology. You can find the food webs we used in our study in Table S1 of the supporting infomation of Heymans et al. (2014) (https://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0095845.s001). Watch out: the enumeration is not the same. Check the data folder for the conversion between our enumeration and their enumeration. Also, we used only 76 food webs out of their 105. 

Heymans, J. J., Coll, M., Libralato, S., Morissette, L., & Christensen, V. (2014). Global patterns in ecological indicators of marine food webs: a modelling approach. PloS one, 9(4), e95845.

## Ecopath with Ecosim food webs.
The food webs included in adjacency_matrices are all taken by the 105 food webs of Ecopath with Ecosim. Inside, you have 105 food webs with loops, which include around 35 food webs that are naturally without cycles. I should include big food webs, but it seems like there are not many of them. Only 10 food webs have no cycles and more than 20 nodes. 8 have at least 23 nodes. 

## Data format

### Edge list
In the edge list, the first column is the prey, the second is the predator and the third is the weight of their link. In the adjacency matrix, a(i,j) is prey i preyed upon by predator j. 

### Adjacency matrix
In MATLAB, A is the adjacency matrix. It needs to be a weighted, directed network.

Example
  A(2,3): species 2 is eaten by species 3.

## REGE
Watch out: this toolbox doesn't implement the REGE algorithm. It needs to be calculated from the UCINET VI software (available only for windows at https://sites.google.com/site/ucinetsoftware/home). The output of UCINET needs then to be transformed into a MATLAB matrix and saved in the folder data. Here I supposed that the maximum of REGE is 1000.

## Dependencies
1. Food Web Analysis Toolbox (https://uk.mathworks.com/matlabcentral/fileexchange/89907-food-web-analysis-toolbox)
2. Netcarto

## Food webs
I got rid of the food web number 5, because it gave me problems with Netcarto. 

## Other
The REGE from the gulf of Napoli is widely 1000 scaled instead of 100 scaled.