library(IRTmixed)

n_items = 15
n_obs=c(500, 1000, 5000)
n_rep=100
initial.seed = 1234

# loop through conditions and submit job file with replications as array
index = 0
for (obs in n_obs) {
  index = index+1
  job.content = makeArgonJobFile(
                         argon_Rscript_path = "~/IRTmixed_sim/Script/argon_glmm_onerep_i15.R",
                         argon_job_path = paste0("~/IRTmixed_sim/job_files/", index, ".sh"),
                         n_obs = obs,
                         n_reps = 1,
                         seed = initial.seed+index*100000
                         )

  write.table(job.content, file = paste0("~/IRTmixed_sim/job_files/argonjob_N", obs, "_Nitems", n_items, ".job"),
              quote=FALSE, row.names=FALSE, col.names=FALSE)

  system(paste0("qsub -t 1-", n_rep, "~/IRTmixed_sim/job_files/argonjob_N", obs, "_Nitems", n_items, ".job"))
}
