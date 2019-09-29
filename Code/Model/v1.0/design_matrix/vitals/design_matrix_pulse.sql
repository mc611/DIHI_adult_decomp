DROP TABLE IF EXISTS design_matrix_pulse;
CREATE TABLE design_matrix_pulse AS
SELECT pulse_cleaned.pat_enc_csn_id
  , pulse_cleaned.pat_id
  , ROUND(julianday(pulse_cleaned.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(pulse_cleaned.meas_value) AS pulse_max
  , MIN(pulse_cleaned.meas_value) AS pulse_min
  , AVG(pulse_cleaned.meas_value) AS pulse_avg
FROM cohort_admission adm
LEFT JOIN pulse_cleaned
  ON adm.pat_enc_csn_id=pulse_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < pulse_cleaned.recorded_time
GROUP BY pulse_cleaned.pat_enc_csn_id, ROUND(julianday(pulse_cleaned.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);