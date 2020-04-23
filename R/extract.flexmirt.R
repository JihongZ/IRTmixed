#' @title Extract flexmirt estimation
#' @param filename the path flexmirt output file
#' @export
extract.flexmirt <- function(filename) {
  estimates.tab <- read.table(filename,
                       comment.char = "",
                       nrows = 15,
                       skip = 69,
                       header = TRUE,
                       row.names = 1)

  estimates <- estimates.tab[,c(3,4,6,7,8,9)]
  column.names <- c("a.parm", "a.se", "d.parm", "d.se", "b.parm", "b.se")
  colnames(estimates) <- column.names
  return(estimates)
}
