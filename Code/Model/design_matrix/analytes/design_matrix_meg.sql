DROP TABLE IF EXISTS design_matrix_meg;
CREATE TABLE design_matrix_meg AS
SELECT meg_cleaned.pat_enc_csn_id
  , meg_cleaned.pat_id
  , ROUND(julianday(meg_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(meg_cleaned.num_value) AS meg_avg
FROM cohort_admission adm
LEFT JOIN meg_cleaned
  ON adm.pat_enc_csn_id=meg_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < meg_cleaned.result_time
GROUP BY meg_cleaned.pat_enc_csn_id, ROUND(julianday(meg_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);