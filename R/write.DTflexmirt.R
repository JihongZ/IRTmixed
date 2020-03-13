#' @title Reshape the data and save sas the format for flexmirt
#' @param x a data.frame object. Each row is observarion, and each column is one item.
#' @param file the path dataset save
#' @import PLmixed
#' @import tidyr
#' @export
#'

write.DTflexmirt <- function(x, file) {
  x <- as.data.frame(x)
  x$PersonID <- 1:nrow(x)

  # Transform to long-form
  x.long <-  gather(x, "ItemID", "Response", -PersonID)
  x.long$ItemID <- as.factor(x.long$ItemID)
  x.long <- x.long[order(x.long$PersonID), ]

  write.table(x[,1:5], file = file, col.names = F, row.names = F, quote = F, sep = " ")
}
