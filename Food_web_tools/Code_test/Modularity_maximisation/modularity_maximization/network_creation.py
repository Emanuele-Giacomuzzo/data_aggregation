import numpy as np
import networkx as nx
import os 
from matplotlib import pyplot as plt
G = nx.read_weighted_edgelist('/Users/ema/Github/Food_web_tools/Code_test/Modularity_maximisation/data/GN_edge_list.txt')
print(nx.info(G))
nx.draw(G)
plt.show()