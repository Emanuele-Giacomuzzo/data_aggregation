# Topological importance 
This r program calculates the topological importance (Jordàn, 2003) up to n steps. A good explanation of topological importance is given by Jordàn (2009). 

## Author
Wei-chung Liu

## Input
The input should be an edge list (.txt) of the undirected binary network. If there is a link between Jon and Tom, the input is as follows:

Jon	Tom	1

Tom	Jon	1

## Code & Algorithm
The first line of the code tells R where your input file is. The second line tells R how many steps up to the TI index should be calculated. The part that follows transform the edge list into a matrix. Then, the algorithm of the topological importance goes as follows:

1. Create the topological importance of the first step. In this matrix, every value is the fraction of the total preys constituted by a prey in the diet of a predator.
2. For the total number of steps
a. yo
b. yo
3. The topological importance of a species is the sum of all its topological importances (sum of its row) at the n step divided by the total number of steps.

## Output 
The output is recorded in a dataframe called resu. 

## References
Jordàn,  F.,  Liu,  W.  C.,  and  van  Veen,  F.  J.  (2003).Quantifying the importance of species and their inter-actions  in  a  host-parasitoid  community.CommunityEcology, 4(1):79–88

Jordàn,  F.  (2009).    Keystone  species  and  food  webs.Philosophical Transactions of the Royal Society B: Bi-ological Sciences, 364(1524):1733–1741
