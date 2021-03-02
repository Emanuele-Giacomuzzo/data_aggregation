# Data_aggregation

## Data format

### Edge list
In the edge list, the first column is the prey, the second is the predator and the third is the weight of their link. In the adjacency matrix, a(i,j) is prey i preyed upon by predator j. 

### Adjacency matrix
In MATLAB, A is the adjacency matrix. It needs to be a weighted, directed network.

Example
  A(2,3): species 2 is eaten by species 3.

## REGE
Watch out: this toolbox doesn't implement the REGE algorithm. It needs to be calculated from the UCINET VI software (available only for windows at https://sites.google.com/site/ucinetsoftware/home). The output of UCINET needs then to be transformed into a matlab matrix and saved in the folder data. Here I supposed that the maximum of REGE is 1000.

## Dependencies
1. "Mann-Kendall Tau-b with Sen's Method (enhanced)" at https://uk.mathworks.com/matlabcentral/fileexchange/11190-mann-kendall-tau-b-with-sen-s-method-enhanced
2. Food web tools at ...
3. Signed group model at https://github.com/elsander/SignedGroupModel

## CosbiLab
It is a semi-developed software, whose some features work only partially. To import a food web:
1. Import food web into UCINET.
2. Export food web as edge list.
3. Change the dot to comma. If there is any connection that it's zero delete it (CosbiLab considers it as if there was a connection.)
Other things to consider:
I. If the food web is weighted, then you need to write 'value' into weight attribute.
II. You can export just certain things such as the keystone index.
III. To calculate the keystone index and the status index you need to transform the food web into a directed acyclic graph (DAG). To do so you need first to find all the cycles. Then, you should get rid of the edges that create the cycles. See the README file. 
