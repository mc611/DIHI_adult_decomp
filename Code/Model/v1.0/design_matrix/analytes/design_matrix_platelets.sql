DROP TABLE IF EXISTS design_matrix_platelets;
CREATE TABLE design_matrix_platelets AS
SELECT platelets_cleaned.pat_enc_csn_id
  , platelets_cleaned.pat_id
  , ROUND(julianday(platelets_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(platelets_cleaned.num_value) AS platelets_avg
FROM cohort_admission adm
LEFT JOIN platelets_cleaned
  ON adm.pat_enc_csn_id=platelets_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < platelets_cleaned.result_time
GROUP BY platelets_cleaned.pat_enc_csn_id, ROUND(julianday(platelets_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);