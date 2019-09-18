DROP TABLE IF EXISTS design_matrix_fluids;
CREATE TABLE design_matrix_fluids AS
SELECT fluids.pat_enc_csn_id
  , ROUND(julianday(fluids.taken_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , SUM(fluids.fluids) AS fluids_taken_times
FROM cohort_admission adm
LEFT JOIN fluids_cleaned fluids
  ON adm.pat_enc_csn_id=fluids.pat_enc_csn_id
WHERE adm.hospital_admission_time < fluids.taken_time
GROUP BY fluids.pat_enc_csn_id, ROUND(julianday(fluids.taken_time) - julianday(adm.hospital_admission_time) + 0.5);