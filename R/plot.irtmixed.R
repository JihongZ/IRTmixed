#' @title main function to fit the IRT model using mixed model
#' @param x a irtmixed object. Each row is observarion, and each column is one item.
#' @import PLmixed
#' @import irtoys
#' @export
#'


plot.irtmixed <- function(x, type = "irf", ...) {
  a.parm <- x$Lambda$lambda.ItemID[, 1] # item discrimination (a)
  d.parm <- x$'Fixed Effects'[,1] # item intercept (d)
  b.parm <- d.parm / a.parm
  item.params <- cbind(a.parm, b.parm, 0)

  if (type == "tif") {
    plot(tif(item.params))
  }else{
    plot(irf(item.params), co = NA, label = T)
  }

}
