#' @param x a data.frame object. Each row is observarion, and each column is one item.
#'
#' @export
#'

IRTmixed <- function(x, seed = 1234, itemtype = "2PL") {
  set.seed(seed)

  dataset <- as.data.frame(x)
  dataset$PersonID <- 1:nrow(dataset)

  N_items <- ncol(dataset)

  # Transform to long-form
  dataset.long <-  gather(dataset, "ItemID", "Response", -PersonID)
  dataset.long$ItemID <- as.factor(dataset.long$ItemID)
  dataset.long$PersonID <- as.factor(dataset.long$PersonID)


  if (itemtype == "2PL") {
    irt2pl.lam = c(a[1], rep(NA, N_items - 1)) # item dicrimation

    # estimate the Lamnba in a faster but not exact way by setting nAGQ to 0
    irt2pl.model <- PLmixed(Response ~ 0 + ItemID + (0 + ability | PersonID),
                            data = dataset.long, load.var = c("ItemID"), family = binomial,
                            factor = list(c("ability")), lambda = list(irt2pl.lam),
                            nAGQ=0, method = 'L-BFGS-B',
                            lower = 0,
                            upper = 2
    )
  }else{
    message("Your itemtype is not supported!")
  }
}
