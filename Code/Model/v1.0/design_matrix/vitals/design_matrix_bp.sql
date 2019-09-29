-- round up the difference between vitals' recorded time and encounter's hospital admission time for each record
-- calculate max, min, avg values for each day
DROP TABLE IF EXISTS design_matrix_bp;
CREATE TABLE design_matrix_bp AS
SELECT bp_cleaned.pat_enc_csn_id
  , bp_cleaned.pat_id
  , ROUND(julianday(bp_cleaned.recorded_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , MAX(bp_cleaned.systolic_bp) AS systolic_bp_max
  , MIN(bp_cleaned.systolic_bp) AS systolic_bp_min
  , AVG(bp_cleaned.systolic_bp) AS systolic_bp_avg
  , MAX(bp_cleaned.diastolic_bp) AS diastolic_bp_max
  , MIN(bp_cleaned.diastolic_bp) AS diastolic_bp_min
  , AVG(bp_cleaned.diastolic_bp) AS diastolic_bp_avg
FROM cohort_admission adm
LEFT JOIN bp_cleaned
  ON adm.pat_enc_csn_id=bp_cleaned.pat_enc_csn_id
WHERE adm.hospital_admission_time < bp_cleaned.recorded_time
GROUP BY bp_cleaned.pat_enc_csn_id, ROUND(julianday(bp_cleaned.recorded_time) - julianday(adm.hospital_admission_time) + 0.5);