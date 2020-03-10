#' @title main function to fit the IRT model using mixed model
#' @param x a data.frame object. Each row is observarion, and each column is one item.
#' @import PLmixed
#' @import tidyr
#' @export
#'

IRTmixed <- function(x, itemtype = "2PL", a.fix = 1, seed = 1234) {
  set.seed(seed)

  dataset <- as.data.frame(x)
  N_items <- ncol(x)
  dataset$PersonID <- 1:nrow(dataset)


  # Transform to long-form
  dataset.long <- gather(dataset, "ItemID", "Response", -PersonID)
  dataset.long$ItemID <- as.factor(dataset.long$ItemID)
  dataset.long$PersonID <- as.factor(dataset.long$PersonID)


  if (itemtype == "2PL") {
    irt2pl.lam = c(1, rep(NA, N_items-1)) # item discrimation
    if (a.fix != 1) {
      irt2pl.lam[1] = a.fix
    }

    # estimate the Lamnba in a faster but not exact way by setting nAGQ to 0
    irt.model <- PLmixed(Response ~ 0 + ItemID + (0 + a | PersonID),
                         data = dataset.long, load.var = c("ItemID"), family = binomial,
                         factor = list(c("a")), lambda = list(irt2pl.lam),
                         nAGQ=0, method = 'L-BFGS-B')
  }else if(itemtype == "1PL"){
    irt.model <- PLmixed(Response ~ 0 + ItemID + (1 | PersonID),
                         data = dataset.long, family = binomial)
  }else{
    message("Your itemtype is not supported!")
  }


  class(irt.model) <- "irtmixed"
  return(irt.model)
}
