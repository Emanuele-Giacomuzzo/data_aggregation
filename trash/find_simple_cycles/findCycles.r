## Code found in https://stackoverflow.com/questions/55091438/r-igraph-find-all-cycles/55094319. It doesn't return long cycles. 
findCycles <- function(g){
  Cycles = NULL
  for(v1 in V(g)) {
    for(v2 in neighbors(g, v1, mode="out")) {
      Cycles = c(Cycles, 
                 lapply(all_simple_paths(g, v2,v1, mode="out"), function(p) c(v1,p)))
    }
  } 
  return(Cycles)
}