DROP TABLE IF EXISTS design_matrix_spo2;
CREATE TABLE design_matrix_spo2 AS
SELECT spo2.pat_enc_csn_id
  , spo2.pat_id
  , ROUND(julianday(spo2.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(spo2.meas_value) AS spo2_max
  , MIN(spo2.meas_value) AS spo2_min
  , AVG(spo2.meas_value) AS spo2_avg
FROM cohort_admission adm
LEFT JOIN pulse_oximetry_cleaned spo2
  ON adm.pat_enc_csn_id=spo2.pat_enc_csn_id
WHERE adm.hospital_admission_time < spo2.recorded_time
GROUP BY spo2.pat_enc_csn_id, ROUND(julianday(spo2.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);