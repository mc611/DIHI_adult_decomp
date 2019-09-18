DROP TABLE IF EXISTS design_matrix_po2;
CREATE TABLE design_matrix_po2 AS
SELECT po2_cleaned.pat_enc_csn_id
  , po2_cleaned.pat_id
  , ROUND(julianday(po2_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(po2_cleaned.num_value) AS po2_avg
FROM cohort_admission adm
LEFT JOIN po2_cleaned
  ON adm.pat_enc_csn_id=po2_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < po2_cleaned.result_time
GROUP BY po2_cleaned.pat_enc_csn_id, ROUND(julianday(po2_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);