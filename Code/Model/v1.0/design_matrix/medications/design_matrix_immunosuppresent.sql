DROP TABLE IF EXISTS design_matrix_immunosuppresent;
CREATE TABLE design_matrix_immunosuppresent AS
SELECT immunosuppresent.pat_enc_csn_id
  , ROUND(julianday(immunosuppresent.taken_time) - julianday(adm.hospital_admission_time) + 0.5) AS days_to_admission
  , SUM(immunosuppresent.immunosuppresent) AS immunosuppresent_taken_times
FROM cohort_admission adm
LEFT JOIN immunosuppresent_cleaned immunosuppresent
  ON adm.pat_enc_csn_id=immunosuppresent.pat_enc_csn_id
WHERE adm.hospital_admission_time < immunosuppresent.taken_time
GROUP BY immunosuppresent.pat_enc_csn_id, ROUND(julianday(immunosuppresent.taken_time) - julianday(adm.hospital_admission_time) + 0.5);