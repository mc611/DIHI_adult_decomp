DROP TABLE IF EXISTS design_matrix_trop;
CREATE TABLE design_matrix_trop AS
SELECT trop_cleaned.pat_enc_csn_id
  , trop_cleaned.pat_id
  , ROUND(julianday(trop_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(trop_cleaned.num_value) AS trop_avg
FROM cohort_admission adm
LEFT JOIN trop_cleaned
  ON adm.pat_enc_csn_id=trop_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < trop_cleaned.result_time
GROUP BY trop_cleaned.pat_enc_csn_id, ROUND(julianday(trop_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);