#This package comes from https://github.com/zhiyzuo/python-modularity-maximization

import networkx as nx
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from modularity_maximization import partition
from modularity_maximization.utils import get_modularity

edge_list_w = pd.read_csv('/Users/ema/github/data_aggregation/data/edge_list_for_R.txt', delimiter='\t')
print(edge_list_w.describe())
G = nx.from_pandas_edgelist(edge_list_w,'prey','predator',["weight"],create_using=nx.DiGraph())
print(nx.info(G))
print(nx.is_directed(G))
#nx.draw(G)
#plt.show()

comm_dict = partition(G)
type(comm_dict)
print(comm_dict)

print('Modularity of such partition is %.3f' %\
      get_modularity(G, comm_dict))
