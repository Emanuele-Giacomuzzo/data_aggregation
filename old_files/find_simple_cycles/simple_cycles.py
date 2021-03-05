py.import networkx as nx
import matplotlib.pyplot as plt
import numbers
import os
import numpy as np
import collections


#For multiple networks
#for root, dirs, files in os.walk('/Users/ema/github/data_aggregation/data/ewe_networks'):
#    for file in files:
#        filename, extension = os.path.splitext(file)
#        if 'edgelist_networkx' in filename:
            # Do Some Task

#For a single network
G = nx.read_edgelist('/Users/ema/github/data_aggregation/data/Napoli/Edgelist_networkx.txt',create_using = nx.DiGraph())
print(nx.info(G))
G.remove_edges_from(nx.selfloop_edges(G))
TP= np.loadtxt('/Users/ema/github/data_aggregation/data/ewe_networks/TP.txt', usecols=None)

#with open("cycles.txt", mode = 'w', newline = '') as f:
#    for cycle in nx.simple_cycles(G):
#        string = ' '.join(str(e) for e in cycle)
#        f.write("%s\n" % string)

#for cycle in nx.simple_cycles(G):
#    cycle = list(map(int, cycle))
#    if len(cycle) == 1:
#        print(cycle)

#A = np.loadtxt('/Users/ema/github/data_aggregation/data/Napoli_A.txt')
#print(A)
#G = nx.from_numpy_array(A,create_using = nx.DiGraph())
#print(nx.info(G))

for cycle in nx.simple_cycles(G):
    cycle_array = np.asarray(cycle)

#print(TP[number])
