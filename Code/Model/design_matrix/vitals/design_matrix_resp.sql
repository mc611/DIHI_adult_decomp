DROP TABLE IF EXISTS design_matrix_resp;
CREATE TABLE design_matrix_resp AS
SELECT resp.pat_enc_csn_id
  , resp.pat_id
  , ROUND(julianday(resp.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(resp.meas_value) AS resp_max
  , MIN(resp.meas_value) AS resp_min
  , AVG(resp.meas_value) AS resp_avg
FROM cohort_admission adm
LEFT JOIN respiratory_rate_cleaned resp
  ON adm.pat_enc_csn_id=resp.pat_enc_csn_id
WHERE adm.hospital_admission_time < resp.recorded_time
GROUP BY resp.pat_enc_csn_id, ROUND(julianday(resp.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);