DROP TABLE IF EXISTS design_matrix_insulin;
CREATE TABLE design_matrix_insulin AS
SELECT insulin.pat_enc_csn_id
  , ROUND(julianday(insulin.taken_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , SUM(insulin.insulin) AS insulin_taken_times
FROM cohort_admission adm
LEFT JOIN insulin_cleaned insulin
  ON adm.pat_enc_csn_id=insulin.pat_enc_csn_id
WHERE adm.hospital_admission_time < insulin.taken_time
GROUP BY insulin.pat_enc_csn_id, ROUND(julianday(insulin.taken_time) - julianday(adm.hospital_admission_time) + 0.5);