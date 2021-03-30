import networkx as nx
import matplotlib.pyplot as plt
import numbers
import os
import numpy as np
import collections

path = '/Users/ema/github/data_aggregation/data/Napoli/Edgelist_networkx.txt'
G = nx.read_edgelist(path,create_using = nx.DiGraph())
print(nx.info(G))

with open("cycles.txt", mode = 'w', newline = '') as f:
    for cycle in nx.simple_cycles(G):
        string = ' '.join(str(e) for e in cycle)
        f.write("%s\n" % string)
