DROP TABLE IF EXISTS outcome_1st_icu_admission;
CREATE TABLE outcome_1st_icu_admission AS
WITH trans AS
(
  SELECT pat_enc_csn_id
    , MIN(transfer_dttm) AS transfer_dttm
  FROM adult_decomp_adt_transfer
  WHERE transfer_in_level_of_care = 'intensive care'
  GROUP BY pat_enc_csn_id
)
SELECT DISTINCT cohort.pat_enc_csn_id
  , cohort.pat_id
  , trans.transfer_dttm
  , CASE WHEN transfer_dttm IS NOT NULL THEN 1
      ELSE 0 END AS icu_admission_label
FROM adult_decomp_cohort cohort
LEFT JOIN trans
  ON cohort.pat_enc_csn_id=trans.pat_enc_csn_id