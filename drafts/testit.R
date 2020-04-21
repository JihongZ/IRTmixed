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

allfiles = NULL
for (obs in 500) {
  for (rep in 1:31) {
    makeFlexmirtJobFile(flexmirt_Rscript_path = "~/IRTmixed_sim/Flexmirt_files/Script/",
                        n_obs = obs,
                        n_reps = rep)
    filename = paste0("glmm_15item_N",obs,"_rep",rep,".flexmirt")
    windows.path = 'C:\\IRTmixed_sim\\Flexmirt_files\\Script\\'
    allfiles = paste(allfiles, paste0(windows.path, filename), sep = "\n")
  }
}
cat(allfiles)
# save flexmirt batch file
write.table(allfiles,
  file = paste0("~/IRTmixed_sim/Flexmirt_files/Script/", "batch.csv"),
  quote=FALSE, row.names=FALSE, col.names=FALSE)


makeFlexmirtJobFile(flexmirt_Rscript_path = "~/IRTmixed_sim/Flexmirt_files/",
                    n_obs = n_obs,
                    n_reps = repnumber)
