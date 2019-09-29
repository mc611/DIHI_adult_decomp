DROP TABLE IF EXISTS design_matrix_hct;
CREATE TABLE design_matrix_hct AS
SELECT hct_cleaned.pat_enc_csn_id
  , hct_cleaned.pat_id
  , ROUND(julianday(hct_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(hct_cleaned.num_value) AS hct_avg
FROM cohort_admission adm
LEFT JOIN hct_cleaned
  ON adm.pat_enc_csn_id=hct_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < hct_cleaned.result_time
GROUP BY hct_cleaned.pat_enc_csn_id, ROUND(julianday(hct_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);