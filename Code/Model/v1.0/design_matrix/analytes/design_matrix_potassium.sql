DROP TABLE IF EXISTS design_matrix_potassium;
CREATE TABLE design_matrix_potassium AS
SELECT potassium_cleaned.pat_enc_csn_id
  , potassium_cleaned.pat_id
  , ROUND(julianday(potassium_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(potassium_cleaned.num_value) AS potassium_avg
FROM cohort_admission adm
LEFT JOIN potassium_cleaned
  ON adm.pat_enc_csn_id=potassium_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < potassium_cleaned.result_time
GROUP BY potassium_cleaned.pat_enc_csn_id, ROUND(julianday(potassium_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);