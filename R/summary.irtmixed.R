#' @title summarize the coefficients of irtmixed object
#' @param x a irtmixed object. Each row is observarion, and each column is one item.
#' @import PLmixed
#' @import irtoys
#' @export
#'
#'

summary.irtmixed <- function(x) {
  a.parm <- x$Lambda$lambda.ItemID[, 1] # item discrimination (a)
  a.se <- x$Lambda$lambda.ItemID[, 2] # item discrimination (a)

  d.parm <- x$'Fixed Effects'[,1] # item intercept (d)
  d.parm <- d.parm[paste0("ItemID",names(a.parm))]

  d.se <- x$`Fixed Effects`[,2]
  d.se <- d.se[paste0("ItemID",names(a.parm))]

  b.parm <- d.parm / a.parm
  sum.table <- cbind(a.parm, a.se, d.parm, d.se, b.parm)
  return(sum.table)
}
