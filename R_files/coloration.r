#ORIGINAL FOOD WEB - JACCARD COLORATION 
V(G)$jaccard <- membership[,1]
V(G)$color <- V(G)$jaccard
plot.igraph(G,
            main = "Jaccard index coloration",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=T,
            #ylab="Trophic position (TP)",
            rescale=F,
            asp=0)
title("",sub="Coloration of the original food web according to the Jaccard index.")

#ORIGINAL FOO WEB - REGE COLORATION  
V(G)$rege <- membership[,2] 
V(G)$color <- V(G)$rege
plot.igraph(G,
            main = "REGE index coloration",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=T,
            #ylab="Trophic position (TP)"
            rescale=F,
            asp=0)
title("",sub="Coloration of the original food web according to the REGE index.")

#ORIGINAL FOOD WEB - PREY MODULARITY COLORATION
V(G)$preymodularity <- membership[,3] 
V(G)$color <- V(G)$preymodularity
plot.igraph(G,
            main = "Prey modules coloration",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=T,
            #ylab="Trophic position (TP)"
            rescale=F,
            asp=0)
title("",sub="Coloration of the original food web according to their prey modules.")

#ORIGINAL FOOD WEB - DENSITY MODULARITY COLORATION
V(G)$densitymodularity <- membership[,4] 
V(G)$color <- V(G)$densitymodularity
plot.igraph(G,
            main = "Density modules coloration",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=T,
            #ylab="Trophic position (TP)"
            rescale=F,
            asp=0)
title("",sub="Coloration of the original food web according to the density modules.")

#ORIGINAL FOOD WEB - GROUP MODEL COLORATION 
V(G)$groups <- membership[,5]
V(G)$color <- V(G)$groups
plot.igraph(G,
            main = "Group modules coloration",
            vertex.label=NA,
            vertex.size=3,
            edge.arrow.size=.25,
            layout=layout.matrix,
            xlim = c(0,1),
            ylim=c(0,3),
            #axes=T,
            #ylab="Trophic position (TP)"
            rescale=F,
            asp=0)
title("",sub="Coloration of the original food web according to the group modules.")
