DROP TABLE IF EXISTS design_matrix_medications;
CREATE TABLE design_matrix_medications AS
SELECT label.pat_enc_csn_id
  , label.days_to_admission
  , CASE WHEN antibiotics.antibiotics_taken_times IS NOT NULL THEN 1
      ELSE 0 END AS antibiotics_taken_flag
  , CASE WHEN fluids.fluids_taken_times IS NOT NULL THEN 1
      ELSE 0 END AS fluids_taken_flag
  , CASE WHEN immunosuppresent.immunosuppresent_taken_times IS NOT NULL THEN 1
      ELSE 0 END AS immunosuppresent_taken_flag
  , CASE WHEN insulin.insulin_taken_times IS NOT NULL THEN 1
      ELSE 0 END AS insulin_taken_flag
  , CASE WHEN vasopressors.vasopressors_taken_times IS NOT NULL THEN 1
      ELSE 0 END AS vasopressors_taken_flag
  , label.icu_admission_flag
FROM design_matrix_days_label label
LEFT JOIN design_matrix_antibiotics antibiotics
  ON label.pat_enc_csn_id=antibiotics.pat_enc_csn_id
  AND label.days_to_admission=antibiotics.days_to_admission
LEFT JOIN design_matrix_fluids fluids
  ON label.pat_enc_csn_id=fluids.pat_enc_csn_id
  AND label.days_to_admission=fluids.days_to_admission
LEFT JOIN design_matrix_immunosuppresent immunosuppresent
  ON label.pat_enc_csn_id=immunosuppresent.pat_enc_csn_id
  AND label.days_to_admission=immunosuppresent.days_to_admission
LEFT JOIN design_matrix_insulin insulin
  ON label.pat_enc_csn_id=insulin.pat_enc_csn_id
  AND label.days_to_admission=insulin.days_to_admission
LEFT JOIN design_matrix_vasopressors vasopressors
  ON label.pat_enc_csn_id=vasopressors.pat_enc_csn_id
  AND label.days_to_admission=vasopressors.days_to_admission;