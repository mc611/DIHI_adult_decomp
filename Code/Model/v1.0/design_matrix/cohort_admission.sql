DROP TABLE IF EXISTS cohort_admission;
CREATE TABLE cohort_admission AS
SELECT DISTINCT pat_enc_csn_id
  , pat_id
  , hospital_admission_time
FROM adult_decomp_cohort;