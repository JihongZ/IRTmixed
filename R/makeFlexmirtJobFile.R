#' @export
makeFlexmirtJobFile = function(flexmirt_Rscript_path,
                            n_obs,
                            n_reps){

  filename = paste0("glmm_15item_N",n_obs,"_rep",n_reps,".flexmirt")
  jobtext = paste0(
'<Project>
  Title = "2Pl example with 15 items";
  Description = "15 items 1 Factor, 1 Group 2PL Calibration";
<Options>
  Mode = Calibration;
  savePRM = Yes;
  GOF=Extended;
  //SaveSCO =YES;
  //Score=MAP;
<Groups>
  %G1%
  File = "C:\\IRTmixed_sim\\Flexmirt_files\\Data\\data_15item_N',
  n_obs,
  "_rep",
  n_reps,
  '.dat";
  Varnames=v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15;
  N=',n_obs,';
  Ncats(v1-v15)=2;
  Model(v1-v15)=Graded(2);
<Constraints>'
)

  # save flexmirt job file
  write.table(jobtext, file = paste0(flexmirt_Rscript_path, filename), quote=FALSE, row.names=FALSE, col.names=FALSE)


}
