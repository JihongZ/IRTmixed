library(mirt)
seed = 1234
N_items = 15
N_people = 200
a_l <- runif(N_items / 3, 0.4, 0.8) # low discrimination
a_m <- runif(N_items / 3, 0.8, 1.2) # mid discrimination
a_h <- runif(N_items / 3, 1.2, 1.6) # hig discrimination
a <- c(a_l, a_m, a_h)

d <- rep(c(-1.5, -.5, 0, -.5, 1.5), N_items / 5) # item intercepts

dt <- simdata(a = a, d = d, N = N_people, itemtype = '2PL')
dim(dt)

mmod2 <- IRTmixed::IRTmixed(x = dt, itemtype = "2PL", seed = 1234, a.fix = a[1])

summary(mmod2)
summary(mmod2_rep2)
plot(mmod2)
plot(mmod2, "tif")

mod1 <- mirt(dt, 1)
coef(mod1)

