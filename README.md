# Data_aggregation

## Input
A is the adjacency matrix. It needs to be a weighted, directed network. 
The species in the rows needs to be eaten by the species in the coloumns.

Example: A(2,3) species 2 is eaten by species 3. 

## Modularity maximisation
It could take some time, normally a couple of minutes. Be patient. 

## REGE
Watch out: this toolbox doesn't implement the REGE algorithm. It needs to be calculated from the UCINET VI software (available only for windows at https://sites.google.com/site/ucinetsoftware/home). The output of UCINET needs then to be transformed into a matlab matrix and saved in the folder data. Here I supposed that the maximum of REGE is 1000.

## Dependencies
1. Intecorellation coefficient (ICC) at https://uk.mathworks.com/matlabcentral/fileexchange/22099-intraclass-correlation-coefficient-icc
2. Food web tools at ...
3. Signed group model at https://github.com/elsander/SignedGroupModel

## Per Nicoluzzo
Il file principale è in Data_aggregation/Matlab_files/main.m. Ci sono un sacco di funzioni che non sono nella stessa cartella, ma nella cartella di Data_aggregation/Food_web_tools. 
