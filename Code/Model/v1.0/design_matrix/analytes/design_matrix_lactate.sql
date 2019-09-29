DROP TABLE IF EXISTS design_matrix_lactate;
CREATE TABLE design_matrix_lactate AS
SELECT lactate_cleaned.pat_enc_csn_id
  , lactate_cleaned.pat_id
  , ROUND(julianday(lactate_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(lactate_cleaned.num_value) AS lactate_avg
FROM cohort_admission adm
LEFT JOIN lactate_cleaned
  ON adm.pat_enc_csn_id=lactate_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < lactate_cleaned.result_time
GROUP BY lactate_cleaned.pat_enc_csn_id, ROUND(julianday(lactate_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);