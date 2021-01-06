# Topological importance 
This r program calculates the topological importance (Jordàn, 2003) up to n steps. A good explanation of topological importance is given by Jordàn (2009). 

## Author
Wei-chung Liu

## Input
The input should be an edge list (.txt) of the undirected binary network. If there is a link between Jon and Tom, the input is as follows:

Jon	Tom	1

Tom	Jon	1

## Code
The first line of the code tells R where your input file is. 

The second line tells R how many steps up to the TI index should be calculated.

## Output 
The output is recorded in a dataframe called resu. 

## References
Jordàn,  F.,  Liu,  W.  C.,  and  van  Veen,  F.  J.  (2003).Quantifying the importance of species and their inter-actions  in  a  host-parasitoid  community.CommunityEcology, 4(1):79–88
Jordàn,  F.  (2009).    Keystone  species  and  food  webs.Philosophical Transactions of the Royal Society B: Bi-ological Sciences, 364(1524):1733–1741
