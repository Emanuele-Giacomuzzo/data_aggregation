G = py.networkx.read_edgelist('/Users/ema/github/data_aggregation/data/Napoli/Edgelist_networkx.txt',pyargs('create_using', py.networkx.DiGraph()));
py.print(py.networkx.info(G))

py.networkx.selfloop_edges(G)
G.remove_edges_from(py.networkx.selfloop_edges(G))