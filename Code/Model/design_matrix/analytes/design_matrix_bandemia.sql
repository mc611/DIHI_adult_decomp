DROP TABLE IF EXISTS design_matrix_bandemia;
CREATE TABLE design_matrix_bandemia AS
SELECT bandemia_cleaned.pat_enc_csn_id
  , bandemia_cleaned.pat_id
  , ROUND(julianday(bandemia_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , AVG(bandemia_cleaned.num_value) AS bandemia_avg
FROM cohort_admission adm
LEFT JOIN bandemia_cleaned
  ON adm.pat_enc_csn_id=bandemia_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < bandemia_cleaned.result_time
GROUP BY bandemia_cleaned.pat_enc_csn_id, ROUND(julianday(bandemia_cleaned.result_time) - julianday(adm.hospital_admission_time) + 0.5);