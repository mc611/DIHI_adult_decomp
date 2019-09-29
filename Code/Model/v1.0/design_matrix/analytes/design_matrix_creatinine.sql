DROP TABLE IF EXISTS design_matrix_creatinine;
CREATE TABLE design_matrix_creatinine AS
SELECT creatinine_cleaned.pat_enc_csn_id
  , creatinine_cleaned.pat_id
  , ROUND(julianday(creatinine_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(creatinine_cleaned.num_value) AS creatinine_avg
FROM cohort_admission adm
LEFT JOIN creatinine_cleaned
  ON adm.pat_enc_csn_id=creatinine_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < creatinine_cleaned.result_time
GROUP BY creatinine_cleaned.pat_enc_csn_id, ROUND(julianday(creatinine_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);