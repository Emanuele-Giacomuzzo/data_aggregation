# Keystone indices 

# Author

Wei-chung liu

## What the program does  

This R program calculates the four different K indices - Kbu, Ktd, Kdir, Kindir. 

## Input format

First, each node has an ID. If there is a link from fish to bird , then the input format must be:

fish	bird	1 (1 indicates a trophic link from fish to bird, meaning bird eats fish).

The first line of the code tells R where your input file is, it should be a textfile.
 
So, just copy and paste the codes into R, then it should work. The result is recorded in a dataframe called resu. So if you type resu and press enter, then it should give you the result.

## How to interpret the output 

Resu has a format like this: nodeID, k, kbu, ktd, kdir, kindir. 
