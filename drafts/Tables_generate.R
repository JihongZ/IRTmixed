########################### 0. Useful Functions
# content
###########################
paste_to_csv <- function(input){
  cat(paste0(input, sep = "\n"))
}

# compute RMSE and Bias in term of true values and estimates
RMSE <- function(est, true) {
  return(sqrt(rowMeans((est - true)^2, na.rm = TRUE)))
}

Bias <- function(est, true) {
  return(rowMeans(est) - true)
}


########################### 0. Read in Data
# Import PLmixed estimates, Flexmirt estimates, True Parameters
###########################
library(dplyr)
path1 <- "~/Downloads/IRTmixed_sim/PLmixed_files/Data/True_Para_N500_rep1.csv"
path2 <- "~/Downloads/IRTmixed_sim/PLmixed_files/Results/"
true_param <- read.csv(path1)

list.files(path2)
estimatesN500.filenames <- paste0("estimates_15item_N500_rep", 1:100, ".csv")
estimatesN500 = list()
length(estimatesN500) = 100
for (onerep in 1:100) {
  estimates.path <- paste0(path2, estimatesN500.filenames[onerep])
  estimatesN500[[onerep]] <- read.csv(file = estimates.path)
}

estimatesN1000.filenames <- paste0("estimates_15item_N1000_rep", 1:100, ".csv")
estimatesN1000 = list()
length(estimatesN1000) = 100
for (onerep in 1:100) {
  estimates.path <- paste0(path2, estimatesN1000.filenames[onerep])
  estimatesN1000[[onerep]] <- read.csv(file = estimates.path)
}

estimatesN5000.filenames <- paste0("estimates_15item_N5000_rep", 1:100, ".csv")
estimatesN5000 = list()
length(estimatesN5000) = 100
for (onerep in 1:100) {
  estimates.path <- paste0(path2, estimatesN5000.filenames[onerep])
  estimatesN5000[[onerep]] <- read.csv(file = estimates.path)
}

estimatesN500[[100]]
estimatesN1000[[100]]
estimatesN5000[[100]]

########################### 1.1 Summary Description for Plmixed
# Compute RMSE, Bias, Mean of estimates, SD of estimates, Mean of Standard Error
###########################

# For 500 sample sizes
## a
a.parm.allrepN500 <- sapply(estimatesN500, function(x) x[,1])
a.se.allrepN500 <- sapply(estimatesN500, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN500, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN500, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN500) %>% paste_to_csv()
apply(a.parm.allrepN500, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN500, na.rm = TRUE) %>% paste_to_csv()

## d
d.parm.allrepN500 <- sapply(estimatesN500, function(x) x[,3])
d.se.allrepN500 <- sapply(estimatesN500, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN500, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN500, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN500) %>% paste_to_csv()
apply(d.parm.allrepN500, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN500, na.rm = TRUE) %>% paste_to_csv()

# For 1000 sample sizes
a.parm.allrepN1000 <- sapply(estimatesN1000, function(x) x[,1])
a.se.allrepN1000 <- sapply(estimatesN1000, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN1000, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN1000, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN1000) %>% paste_to_csv()
apply(a.parm.allrepN1000, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN1000, na.rm = TRUE) %>% paste_to_csv()


## d
d.parm.allrepN1000 <- sapply(estimatesN1000, function(x) x[,3])
d.se.allrepN1000 <- sapply(estimatesN1000, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN1000, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN1000, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN1000) %>% paste_to_csv()
apply(d.parm.allrepN1000, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN1000, na.rm = TRUE) %>% paste_to_csv()


# For 5000 sample sizes
a.parm.allrepN5000 <- sapply(estimatesN5000, function(x) x[,1])
a.se.allrepN5000 <- sapply(estimatesN5000, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN5000, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN5000, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN5000) %>% paste_to_csv()
apply(a.parm.allrepN5000, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN5000, na.rm = TRUE) %>% paste_to_csv()


## d
d.parm.allrepN5000 <- sapply(estimatesN5000, function(x) x[,3])
d.se.allrepN5000 <- sapply(estimatesN5000, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN5000, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN5000, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN5000) %>% paste_to_csv()
apply(d.parm.allrepN5000, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN5000, na.rm = TRUE) %>% paste_to_csv()

########################### 1.2 Summary Description for flexMIRT
# Compute RMSE, Bias, Mean of estimates, SD of estimates, Mean of Standard Error
###########################

# For 500 sample size
filenames <- list.files(path = "~/IRTmixed_sim/Flexmirt_files/Results/", pattern = "glmm_15item_N500(.*?)-irt.txt")
filepath <- paste0("~/IRTmixed_sim/Flexmirt_files/Results/", filenames)
estimatesN500.flex <- lapply(filepath, IRTmixed:::extract.flexmirt)


a.parm.allrepN500.flex <- sapply(estimatesN500.flex, function(x) x[,1])
a.se.allrepN500.flex <- sapply(estimatesN500.flex, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN500.flex, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN500.flex, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN500.flex) %>% paste_to_csv()
apply(a.parm.allrepN500.flex, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN500.flex, na.rm = TRUE) %>% paste_to_csv()

d.parm.allrepN500.flex <- sapply(estimatesN500.flex, function(x) x[,3])
d.se.allrepN500.flex <- sapply(estimatesN500.flex, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN500.flex, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN500.flex, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN500.flex) %>% paste_to_csv()
apply(d.parm.allrepN500.flex, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN500.flex, na.rm = TRUE) %>% paste_to_csv()




# For 1000 sample sizes
filenamesN1000 <- list.files(path = "~/IRTmixed_sim/Flexmirt_files/Results/",
                             pattern = "glmm_15item_N1000(.*?)-irt.txt")
filepath <- paste0("~/IRTmixed_sim/Flexmirt_files/Results/", filenamesN1000)
estimatesN1000.flex <- lapply(filepath, IRTmixed:::extract.flexmirt)


a.parm.allrepN1000.flex <- sapply(estimatesN1000.flex, function(x) x[,1])
a.se.allrepN1000.flex <- sapply(estimatesN1000.flex, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN1000.flex, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN1000.flex, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN1000.flex) %>% paste_to_csv()
apply(a.parm.allrepN1000.flex, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN1000.flex, na.rm = TRUE) %>% paste_to_csv()

d.parm.allrepN1000.flex <- sapply(estimatesN1000.flex, function(x) x[,3])
d.se.allrepN1000.flex <- sapply(estimatesN1000.flex, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN1000.flex, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN1000.flex, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN1000.flex) %>% paste_to_csv()
apply(d.parm.allrepN1000.flex, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN1000.flex, na.rm = TRUE) %>% paste_to_csv()


# For 5000 sample sizes
filenamesN5000 <- list.files(path = "~/IRTmixed_sim/Flexmirt_files/Results/",
                             pattern = "glmm_15item_N5000(.*?)-irt.txt")
filepath <- paste0("~/IRTmixed_sim/Flexmirt_files/Results/", filenamesN5000)
estimatesN5000.flex <- lapply(filepath, IRTmixed:::extract.flexmirt)


a.parm.allrepN5000.flex <- sapply(estimatesN5000.flex, function(x) x[,1])
a.se.allrepN5000.flex <- sapply(estimatesN5000.flex, function(x) x[,2])
a.true <- true_param[,1]
RMSE(a.parm.allrepN5000.flex, a.true) %>% paste_to_csv()
Bias(a.parm.allrepN5000.flex, a.true) %>% paste_to_csv()
rowMeans(a.parm.allrepN5000.flex) %>% paste_to_csv()
apply(a.parm.allrepN5000.flex, 1, sd) %>% paste_to_csv()
rowMeans(a.se.allrepN5000.flex, na.rm = TRUE) %>% paste_to_csv()

d.parm.allrepN5000.flex <- sapply(estimatesN5000.flex, function(x) x[,3])
d.se.allrepN5000.flex <- sapply(estimatesN5000.flex, function(x) x[,4])
d.true <- true_param[,3]
RMSE(d.parm.allrepN5000.flex, d.true) %>% paste_to_csv()
Bias(d.parm.allrepN5000.flex, d.true) %>% paste_to_csv()
rowMeans(d.parm.allrepN5000.flex) %>% paste_to_csv()
apply(d.parm.allrepN5000.flex, 1, sd) %>% paste_to_csv()
rowMeans(d.se.allrepN5000.flex, na.rm = TRUE) %>% paste_to_csv()
