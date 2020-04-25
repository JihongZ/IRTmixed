library(IRTmixed)
allfiles = NULL
for (obs in c(5000)) {
  for (rep in 1:100) {
    # save all flexmirt syntax to the Script folder
    makeFlexmirtJobFile(flexmirt_Rscript_path = "~/IRTmixed_sim/Flexmirt_files/Script/",
                        n_obs = obs,
                        n_reps = rep)
    # the flexmirt syntax filenames, to save to .batch file
    filename = paste0("glmm_15item_N",obs,"_rep",rep,".flexmirt")
    windows.path = 'C:\\IRTmixed_sim\\Flexmirt_files\\Script\\'
    allfiles = paste(allfiles, paste0(windows.path, filename), sep = "\n")
  }
}

# save flexmirt batch file
write.table(allfiles,
            file = paste0("~/IRTmixed_sim/Flexmirt_files/Script/", "batch.csv"),
            quote=FALSE, row.names=FALSE, col.names=FALSE)

cat(allfiles)

########################### 2. Summarize Flexmirt
# CD the directory of flexmirt output file *-irt.txt
# extract flexmirt parameter estimates using extract.flexmirt()
###########################
filenames <- list.files(path = "~/Desktop/Results/", pattern = "-irt.txt")
filepath <- paste0("~/Desktop/Results/", filenames)
Param.list <- lapply(filepath, IRTmixed:::extract.flexmirt)

