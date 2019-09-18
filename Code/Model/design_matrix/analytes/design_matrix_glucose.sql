DROP TABLE IF EXISTS design_matrix_glucose;
CREATE TABLE design_matrix_glucose AS
SELECT glucose_cleaned.pat_enc_csn_id
  , glucose_cleaned.pat_id
  , ROUND(julianday(glucose_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(glucose_cleaned.num_value) AS glucose_avg
FROM cohort_admission adm
LEFT JOIN glucose_cleaned
  ON adm.pat_enc_csn_id=glucose_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < glucose_cleaned.result_time
GROUP BY glucose_cleaned.pat_enc_csn_id, ROUND(julianday(glucose_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);