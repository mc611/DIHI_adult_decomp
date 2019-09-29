DROP TABLE IF EXISTS design_matrix_loc;
CREATE TABLE design_matrix_loc AS
SELECT loc.pat_enc_csn_id
  , loc.pat_id
  , ROUND(julianday(loc.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(CASE WHEN loc.meas_value='Non-Alert' THEN 1
          ELSE 0 END) AS loc_non_alert
FROM cohort_admission adm
LEFT JOIN level_of_consciousness_cleaned loc
  ON adm.pat_enc_csn_id=loc.pat_enc_csn_id
WHERE adm.hospital_admission_time < loc.recorded_time
GROUP BY loc.pat_enc_csn_id, ROUND(julianday(loc.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);