DROP TABLE IF EXISTS outcome_mortality;
CREATE TABLE outcome_mortality AS
SELECT DISTINCT pat_enc_csn_id
  , pat_id
  , death_date
  , CASE WHEN death_date IS NOT NULL THEN 1
    ELSE 0 END AS expire_flag
FROM adult_decomp_cohort;