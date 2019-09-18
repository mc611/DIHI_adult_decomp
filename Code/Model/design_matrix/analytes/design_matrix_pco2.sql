DROP TABLE IF EXISTS design_matrix_pco2;
CREATE TABLE design_matrix_pco2 AS
SELECT pco2_cleaned.pat_enc_csn_id
  , pco2_cleaned.pat_id
  , ROUND(julianday(pco2_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(pco2_cleaned.num_value) AS pco2_avg
FROM cohort_admission adm
LEFT JOIN pco2_cleaned
  ON adm.pat_enc_csn_id=pco2_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < pco2_cleaned.result_time
GROUP BY pco2_cleaned.pat_enc_csn_id, ROUND(julianday(pco2_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);