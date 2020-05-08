#' @export
makeArgonJobFile = function(argon_Rscript_path,
                            argon_job_path,
                            n_obs,
                            n_reps,
                            seed){


  jobtext = "
    #!/bin/bash

    #####Set Scheduler Configuration Directives#####
    #Name the job:
    #$ -N irtmixedReps

    #Redirect standard output to null for high-throughput job:
    #$ -j y

    #Send e-mail at beginning/end/suspension of job
    #$ -m e

    #Start script in current working directory
    #$ -cwd

    #E-mail address to send to
    #$ -M jihong-zhang@uiowa.edu
    #####End Set Scheduler Configuration Directives#####


    #####Resource Selection Directives#####
    #See the HPC wiki for complete resource information: https://wiki.uiowa.edu/display/hpcdocs/Argon+Cluster
    #Select the queue to run in
    #$ -q all.q

    #####End Resource Selection Directives#####

    module load R/3.5.1
    module load gcc

  "


  jobtext = c(jobtext,
              paste("Rscript", argon_Rscript_path, n_obs, n_reps, seed, "$SGE_TASK_ID"))

  return(jobtext)
}
