DROP TABLE IF EXISTS design_matrix_antibiotics;
CREATE TABLE design_matrix_antibiotics AS
SELECT antibiotics.pat_enc_csn_id
  , ROUND(julianday(antibiotics.taken_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , SUM(antibiotics.antibiotics) AS antibiotics_taken_times
FROM cohort_admission adm
LEFT JOIN antibiotics_cleaned antibiotics
  ON adm.pat_enc_csn_id=antibiotics.pat_enc_csn_id
WHERE adm.hospital_admission_time < antibiotics.taken_time
GROUP BY antibiotics.pat_enc_csn_id, ROUND(julianday(antibiotics.taken_time) - julianday(adm.hospital_admission_time) + 0.5);