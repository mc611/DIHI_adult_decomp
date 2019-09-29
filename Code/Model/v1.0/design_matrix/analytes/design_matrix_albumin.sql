DROP TABLE IF EXISTS design_matrix_albumin;
CREATE TABLE design_matrix_albumin AS
SELECT albumin_cleaned.pat_enc_csn_id
  , albumin_cleaned.pat_id
  , ROUND(julianday(albumin_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(albumin_cleaned.num_value) AS albumin_avg
FROM cohort_admission adm
LEFT JOIN albumin_cleaned
  ON adm.pat_enc_csn_id=albumin_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < albumin_cleaned.result_time
GROUP BY albumin_cleaned.pat_enc_csn_id, ROUND(julianday(albumin_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);