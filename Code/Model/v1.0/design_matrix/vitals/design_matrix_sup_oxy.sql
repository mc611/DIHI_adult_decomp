DROP TABLE IF EXISTS design_matrix_sup_oxy;
CREATE TABLE design_matrix_sup_oxy AS
SELECT O2.pat_enc_csn_id
  , O2.pat_id
  , ROUND(julianday(O2.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(O2.o2) AS sup_oxy_flag
FROM cohort_admission adm
LEFT JOIN O2
  ON adm.pat_enc_csn_id=O2.pat_enc_csn_id
WHERE adm.hospital_admission_time < O2.recorded_time
GROUP BY O2.pat_enc_csn_id, ROUND(julianday(O2.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);