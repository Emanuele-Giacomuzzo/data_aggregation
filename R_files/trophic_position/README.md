# Trophic position

## Author
Wei-chung Liu

## What it does

Here is the programe for calculating trophic position (as in Levin 1980) in R. 

## Code 
The first line of the code tells R where your input file is, it should be a textfile.

## Input
The input format is as follows. First, each node has an ID. If there is a link from fish to bird , then the input format must be:
fish	bird	1
(1 indicates a trophic link from fish to bird, meaning bird eats fish).

## Output
 
So, just copy and paste the codes into R, then it should work. The result is recorded in a vector called tp. So if you type tp and press enter, then it should give you the result.