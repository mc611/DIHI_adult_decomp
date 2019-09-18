DROP TABLE IF EXISTS design_matrix_analytes;
CREATE TABLE design_matrix_analytes AS
SELECT label.pat_enc_csn_id
  , label.days_to_admission
  , albumin.albumin_avg
  , bun.bun_avg
  , creatinine.creatinine_avg
  , hct.hct_avg
  , inr.inr_avg
  , meg.meg_avg
  , platelets.platelets_avg
  , potassium.potassium_avg
  , sodium.sodium_avg
  , wbc.wbc_avg
  , glucose.glucose_avg
  , label.icu_admission_flag
FROM design_matrix_days_label label
LEFT JOIN design_matrix_albumin albumin
  ON label.pat_enc_csn_id=albumin.pat_enc_csn_id
  AND label.days_to_admission=albumin.days_to_admission
LEFT JOIN design_matrix_bun bun
  ON label.pat_enc_csn_id=bun.pat_enc_csn_id
  AND label.days_to_admission=bun.days_to_admission
LEFT JOIN design_matrix_creatinine creatinine
  ON label.pat_enc_csn_id=creatinine.pat_enc_csn_id
  AND label.days_to_admission=creatinine.days_to_admission
LEFT JOIN design_matrix_hct hct
  ON label.pat_enc_csn_id=hct.pat_enc_csn_id
  AND label.days_to_admission=hct.days_to_admission
LEFT JOIN design_matrix_inr inr
  ON label.pat_enc_csn_id=inr.pat_enc_csn_id
  AND label.days_to_admission=inr.days_to_admission
LEFT JOIN design_matrix_meg meg
  ON label.pat_enc_csn_id=meg.pat_enc_csn_id
  AND label.days_to_admission=meg.days_to_admission
LEFT JOIN design_matrix_platelets platelets
  ON label.pat_enc_csn_id=platelets.pat_enc_csn_id
  AND label.days_to_admission=platelets.days_to_admission
LEFT JOIN design_matrix_potassium potassium
  ON label.pat_enc_csn_id=potassium.pat_enc_csn_id
  AND label.days_to_admission=potassium.days_to_admission
LEFT JOIN design_matrix_sodium sodium
  ON label.pat_enc_csn_id=sodium.pat_enc_csn_id
  AND label.days_to_admission=sodium.days_to_admission
LEFT JOIN design_matrix_wbc wbc
  ON label.pat_enc_csn_id=wbc.pat_enc_csn_id
  AND label.days_to_admission=wbc.days_to_admission
LEFT JOIN design_matrix_glucose glucose
  ON label.pat_enc_csn_id=glucose.pat_enc_csn_id
  AND label.days_to_admission=glucose.days_to_admission