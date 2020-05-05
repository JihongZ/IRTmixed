########################### 0. Preparation
# Load Package and some self-defined functions
###########################
# setwd("~/OneDrive - University of Iowa/2020 Spring/Advanced IRT/Project")

args = commandArgs(trailingOnly = TRUE)

if (!require(IRTmixed)) {
  devtools::install_github("jihongz/IRTmixed", force = TRUE, dependencies = FALSE)
}else{
  library(IRTmixed)
}

library(PLmixed)
library(mirt)

########################### 0. Hyperparameters
# content
###########################
n_obs = as.numeric(args[1])
repnumber = as.numeric(args[2])
initseed = as.numeric(args[3])
repseed = initseed+repnumber

# n_obs = 500
# repnumber = 100
# initseed = 1234

########################### 1. Single trial
# Generate data for 15-item scale, 3 different sample sizes
###########################
# for 15-item scale
sim.parm.condition1 <- function(seed) {
  set.seed(seed)
  a.low <- runif(5, .4, .8)
  a.mid <- runif(5, .8, 1.2)
  a.hig <- runif(5, 1.2, 1.6)
  a <- c(a.low, a.mid, a.hig)
  b <- rep(c(-1.5, -.5, 0, .5, 1.5), 3)
  d <- a * (-b)
  return(cbind(a, b, d))
}

true.parm <- sim.parm.condition1(seed = 1234)

########################### 1. Data Simulation
# Condition 1/2/3
###########################
set.seed(repseed)
sim.data <- mirt::simdata(a = true.parm[,1], d = true.parm[,3], N = n_obs, itemtype = "2PL")


########################### 2. Save Data file for flexmirt
# Save data file to Flexmirt_files folder
###########################
IRTmixed::write.DTflexmirt(sim.data, paste0("~/IRTmixed_sim/Flexmirt_files/data_15item_N",n_obs,"_rep",repnumber,".dat" ))

########################### 3. Save Data files for PLmixed
# Save data files to PLmixed_files folder
###########################
write.csv(true.parm, row.names = FALSE,
          file = paste0("~/IRTmixed_sim/PLmixed_files/True_Para","_N", n_obs, "_rep", repnumber, ".csv"))
write.csv(sim.data, row.names = FALSE,
          file = paste0("~/IRTmixed_sim/PLmixed_files/data_15item_N",n_obs,"_rep",repnumber,".csv"))

########################### 4. Run GLMM for PLmixed datasets
# Read in the saved data
# Using IRT mixed functions to fit 2PL model to those files
# save the estimated parameters
###########################
dt <- read.csv(file = paste0("~/irtmixed_sim/plmixed_files/data_15item_n",n_obs,"_rep",repnumber,".csv"))

mmod1 <- irtmixed::irtmixed(x = dt, itemtype = "2pl", a.fix = true.parm[1,1])

mmod1.param <- summary(mmod1)


########################### 5. Save Results
# Save Estimates to Results folder
###########################
write.csv(mmod1.param,
          file = paste0("~/IRTmixed_sim/PLmixed_files/Results/estimates_15item_N",n_obs, "_rep", repnumber,".csv"), row.names = FALSE)
