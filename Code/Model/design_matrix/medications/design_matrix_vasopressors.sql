DROP TABLE IF EXISTS design_matrix_vasopressors;
CREATE TABLE design_matrix_vasopressors AS
SELECT vasopressors.pat_enc_csn_id
  , ROUND(julianday(vasopressors.taken_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , SUM(vasopressors.vasopressors) AS vasopressors_taken_times
FROM cohort_admission adm
LEFT JOIN vasopressors_cleaned vasopressors
  ON adm.pat_enc_csn_id=vasopressors.pat_enc_csn_id
WHERE adm.hospital_admission_time < vasopressors.taken_time
GROUP BY vasopressors.pat_enc_csn_id, ROUND(julianday(vasopressors.taken_time) - julianday(adm.hospital_admission_time) + 0.5);