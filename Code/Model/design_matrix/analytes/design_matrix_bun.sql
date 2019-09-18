DROP TABLE IF EXISTS design_matrix_bun;
CREATE TABLE design_matrix_bun AS
SELECT bun_cleaned.pat_enc_csn_id
  , bun_cleaned.pat_id
  , ROUND(julianday(bun_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(bun_cleaned.num_value) AS bun_avg
FROM cohort_admission adm
LEFT JOIN bun_cleaned
  ON adm.pat_enc_csn_id=bun_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < bun_cleaned.result_time
GROUP BY bun_cleaned.pat_enc_csn_id, ROUND(julianday(bun_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);