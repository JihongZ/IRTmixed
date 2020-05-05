# IRTmixed
A R package to fit IRT model (1PL, 2PL, GRM, PRM) in linear mixed model framework

# Usage
```
dt <- read.csv(file = paste0("~/irtmixed_sim/plmixed_files/data_15item_n",n_obs,"_rep",repnumber,".csv"))

mmod1 <- irtmixed::irtmixed(x = dt, itemtype = "2pl", a.fix = true.parm[1,1])

mmod1.param <- summary(mmod1)
```
