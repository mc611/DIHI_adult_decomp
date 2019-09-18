DROP TABLE IF EXISTS design_matrix_temp;
CREATE TABLE design_matrix_temp AS
SELECT temp.pat_enc_csn_id
  , temp.pat_id
  , ROUND(julianday(temp.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(temp.meas_value) AS temp_max
  , MIN(temp.meas_value) AS temp_min
  , AVG(temp.meas_value) AS temp_avg
FROM cohort_admission adm
LEFT JOIN temperature_cleaned temp
  ON adm.pat_enc_csn_id=temp.pat_enc_csn_id
WHERE adm.hospital_admission_time < temp.recorded_time
GROUP BY temp.pat_enc_csn_id, ROUND(julianday(temp.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);