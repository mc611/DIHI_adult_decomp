DROP TABLE IF EXISTS design_matrix_ph;
CREATE TABLE design_matrix_ph AS
SELECT ph_cleaned.pat_enc_csn_id
  , ph_cleaned.pat_id
  , ROUND(julianday(ph_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(ph_cleaned.num_value) AS ph_avg
FROM cohort_admission adm
LEFT JOIN ph_cleaned
  ON adm.pat_enc_csn_id=ph_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < ph_cleaned.result_time
GROUP BY ph_cleaned.pat_enc_csn_id, ROUND(julianday(ph_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);