DROP TABLE IF EXISTS outcome_floor_to_stepdown;
CREATE TABLE outcome_floor_to_stepdown AS
SELECT adult_decomp_cohort.pat_enc_csn_id
  , adult_decomp_cohort.pat_id
  , transfer_true.transfer_dttm
  , CASE WHEN transfer_true.transfer_dttm IS NOT NULL THEN 1
    ELSE 0 END AS floor_to_stepdown_flag
FROM adult_decomp_cohort
LEFT JOIN
(
  SELECT pat_enc_csn_id
    , transfer_dttm
  FROM adult_decomp_adt_transfer
  WHERE transfer_type='floor to stepdown'
) transfer_true
  ON adult_decomp_cohort.pat_enc_csn_id = transfer_true.pat_enc_csn_id;