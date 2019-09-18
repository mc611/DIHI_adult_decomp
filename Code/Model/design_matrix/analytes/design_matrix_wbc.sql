DROP TABLE IF EXISTS design_matrix_wbc;
CREATE TABLE design_matrix_wbc AS
SELECT wbc_cleaned.pat_enc_csn_id
  , wbc_cleaned.pat_id
  , ROUND(julianday(wbc_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(wbc_cleaned.num_value) AS wbc_avg
FROM cohort_admission adm
LEFT JOIN wbc_cleaned
  ON adm.pat_enc_csn_id=wbc_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < wbc_cleaned.result_time
GROUP BY wbc_cleaned.pat_enc_csn_id, ROUND(julianday(wbc_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);