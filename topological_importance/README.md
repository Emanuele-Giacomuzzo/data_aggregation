#Topological importance 

Here is the programe for calculating TI up to n steps in R. The input format is as follows. First, each node has an ID. If there is a link between Jon and Tom, then the input format must be:
Jon	Tom	1
Tom	Jon	1
(1 indicates a link between two nodes. Since there is a link between Jon and Tom, so there is a link from Jon to Tom, and a link from Tom to Jon.).

The first line of the code tells R where your input file is, it should be a textfile. The second line tells R how many steps up to the TI index should be calculated.

So, just copy and paste the codes into R, then it should work. The result is recorded in a dataframe called resu. So if you type resu and press enter, then it should give you the result.
