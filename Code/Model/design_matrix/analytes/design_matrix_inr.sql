DROP TABLE IF EXISTS design_matrix_inr;
CREATE TABLE design_matrix_inr AS
SELECT inr_cleaned.pat_enc_csn_id
  , inr_cleaned.pat_id
  , ROUND(julianday(inr_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(inr_cleaned.num_value) AS inr_avg
FROM cohort_admission adm
LEFT JOIN inr_cleaned
  ON adm.pat_enc_csn_id=inr_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < inr_cleaned.result_time
GROUP BY inr_cleaned.pat_enc_csn_id, ROUND(julianday(inr_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);