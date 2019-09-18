DROP TABLE IF EXISTS design_matrix_sodium;
CREATE TABLE design_matrix_sodium AS
SELECT sodium_cleaned.pat_enc_csn_id
  , sodium_cleaned.pat_id
  , ROUND(julianday(sodium_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(sodium_cleaned.num_value) AS sodium_avg
FROM cohort_admission adm
LEFT JOIN sodium_cleaned
  ON adm.pat_enc_csn_id=sodium_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < sodium_cleaned.result_time
GROUP BY sodium_cleaned.pat_enc_csn_id, ROUND(julianday(sodium_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);