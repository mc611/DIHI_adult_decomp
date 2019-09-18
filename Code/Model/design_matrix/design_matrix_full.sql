DROP TABLE IF EXISTS design_matrix_full;
CREATE TABLE design_matrix_full AS
SELECT dem.pat_enc_csn_id
  , dem.days_to_admission
  , dem.age
  , dem.is_male
  , dem.race_is_white
  , dem.race_is_black
  , dem.race_other
  , vitals.systolic_bp_max
  , vitals.systolic_bp_min
  , vitals.systolic_bp_avg
  , vitals.diastolic_bp_max
  , vitals.diastolic_bp_min
  , vitals.diastolic_bp_avg
  , vitals.loc_non_alert
  , vitals.sup_oxy_flag
  , vitals.pulse_max
  , vitals.pulse_min
  , vitals.pulse_avg
  , vitals.spo2_max
  , vitals.spo2_min
  , vitals.spo2_avg
  , vitals.resp_max
  , vitals.resp_min
  , vitals.resp_avg
  , vitals.temp_max
  , vitals.temp_min
  , vitals.temp_avg
  , vitals_miss.systolic_bp_miss_flag
  , vitals_miss.diastolic_bp_miss_flag
  , vitals_miss.loc_miss_flag
  , vitals_miss.sup_oxy_miss_flag
  , vitals_miss.pulse_miss_flag
  , vitals_miss.spo2_miss_flag
  , vitals_miss.resp_miss_flag
  , vitals_miss.temp_miss_flag
  , analytes.albumin_avg
  , analytes.bun_avg
  , analytes.creatinine_avg
  , analytes.hct_avg
  , analytes.inr_avg
  , analytes.meg_avg
  , analytes.platelets_avg
  , analytes.potassium_avg
  , analytes.sodium_avg
  , analytes.wbc_avg
  , analytes.glucose_avg
  , analytes_miss.albumin_miss_flag
  , analytes_miss.bun_miss_flag
  , analytes_miss.creatinine_miss_flag
  , analytes_miss.hct_miss_flag
  , analytes_miss.inr_miss_flag
  , analytes_miss.meg_miss_flag
  , analytes_miss.platelets_miss_flag
  , analytes_miss.potassium_miss_flag
  , analytes_miss.sodium_miss_flag
  , analytes_miss.wbc_miss_flag
  , analytes_miss.glucose_miss_flag
  , medications.antibiotics_taken_flag
  , medications.fluids_taken_flag
  , medications.immunosuppresent_taken_flag
  , medications.insulin_taken_flag
  , medications.vasopressors_taken_flag
  , diags.diabetes_flag
  , diags.malignancy_flag
  , diags.ckd_flag
  , diags.copd_flag
  , diags.mi_flag
  , diags.hiv_flag
  , dem.icu_admission_flag
FROM design_matrix_demographic dem
INNER JOIN design_matrix_vitals_cleaned vitals
  ON dem.pat_enc_csn_id=vitals.pat_enc_csn_id
  AND dem.days_to_admission=vitals.days_to_admission
INNER JOIN vitals_miss_flag vitals_miss
  ON dem.pat_enc_csn_id=vitals_miss.pat_enc_csn_id
  AND dem.days_to_admission=vitals_miss.days_to_admission
INNER JOIN design_matrix_analytes_cleaned analytes
  ON dem.pat_enc_csn_id=analytes.pat_enc_csn_id
  AND dem.days_to_admission=analytes.days_to_admission
INNER JOIN analytes_miss_flag analytes_miss
  ON dem.pat_enc_csn_id=analytes_miss.pat_enc_csn_id
  AND dem.days_to_admission=analytes_miss.days_to_admission
INNER JOIN design_matrix_medications medications
  ON dem.pat_enc_csn_id=medications.pat_enc_csn_id
  AND dem.days_to_admission=medications.days_to_admission
INNER JOIN design_matrix_diags diags
  ON dem.pat_enc_csn_id=diags.pat_enc_csn_id
  AND dem.days_to_admission=diags.days_to_admission;