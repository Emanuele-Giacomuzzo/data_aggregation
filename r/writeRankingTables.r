writeRankingTables = function (table,caption) {
  
  table_path = paste0("results/tables/",table,".txt")
  if (table == "rank_table"){
    table_path_latex = paste0("latex/tables/",table,".tex")
  } else {
    table_path_latex = paste0("supporting_information/tables/",table,".tex")
  }
  
  
  
  rank_table = read.csv(table_path)
  print(xtable(rank_table, type = "latex"), file = table_path_latex, include.rownames=FALSE)
  rank_table_latex = readLines(table_path_latex)
  
  rank_table_latex = gsub(pattern = "Jaccard", replace = "{\\\\color[HTML]{00D768}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "REGE", replace = "{\\\\color[HTML]{EF2A00}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "predator", replace = "{\\\\color[HTML]{0051D7}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "prey", replace = "{\\\\color{orange}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "groups", replace = "{\\\\color[HTML]{6200D7}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "density", replace = "{\\\\color[HTML]{9B9B9B}", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "\\(", replace = "", x = rank_table_latex)
  rank_table_latex = gsub(pattern = ")", replace = "}", x = rank_table_latex)
  #rank_table_latex = gsub(pattern = "\\\\%", replace = "%", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "llllll", replace = "lllllll", x = rank_table_latex)
  rank_table_latex = gsub(pattern = "C1 & C2 & C3 & C4 & C5 & C6 ", replace = "Index & C1 & C2 & C3 & C4 & C5 & C6 ", x = rank_table_latex)
  #rank_table_latex[1] = "\\documentclass[onecolumn]{article} \\renewcommand{\\arraystretch}{1.5}"
  #rank_table_latex[2] = "\\begin{document}"
  rank_table_latex[33] = "\\end{tabular}"
  rank_table_latex[34] = caption
  #rank_table_latex[36] = "\\end{document}"
  
  for (row in 9:32){
    rank_table_latex[row] = paste(centralities[row-8], rank_table_latex[row])
  }
  
  write(rank_table_latex, file = table_path_latex)
}