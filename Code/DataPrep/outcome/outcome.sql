DROP TABLE IF EXISTS outcome;
CREATE TABLE outcome AS
WITH transfer_true AS
(
  SELECT DISTINCT pat_enc_csn_id
  FROM adult_decomp_adt_transfer
  WHERE transfer_type IN ('ED to ICU', 'stepdown to ICU', 'floor to ICU', 'floor to stepdown')
)
SELECT DISTINCT pat_enc_csn_id
  , pat_id
  , loc_name
  , admission_type
  , sex
  , race
  , age
  , length_of_stay
  , CASE WHEN death_date IS NOT NULL THEN 1
    ELSE 0 END AS expire_flag
  , CASE WHEN pat_enc_csn_id IN
      (
        SELECT DISTINCT pat_enc_csn_id
        FROM adult_decomp_adt_transfer
        WHERE transfer_type = 'stepdown to ICU'
          OR transfer_type = 'floor to ICU'
      )
      THEN 1
    ELSE 0 END AS icu_admission_flag
  , CASE WHEN pat_enc_csn_id IN
      (
        SELECT DISTINCT pat_enc_csn_id
        FROM adult_decomp_adt_transfer
        WHERE transfer_type = 'stepdown to ICU'
      )
      THEN 1
    ELSE 0 END AS stepdown_to_ICU_flag
  , CASE WHEN pat_enc_csn_id IN
      (
        SELECT DISTINCT pat_enc_csn_id
        FROM adult_decomp_adt_transfer
        WHERE transfer_type = 'floor to ICU'
      )
      THEN 1
    ELSE 0 END AS floor_to_ICU_flag
  , CASE WHEN pat_enc_csn_id IN
      (
        SELECT DISTINCT pat_enc_csn_id
        FROM adult_decomp_adt_transfer
        WHERE transfer_type = 'floor to stepdown'
      )
      THEN 1
    ELSE 0 END AS floor_to_stepdown_flag
  , CASE WHEN pat_enc_csn_id IN transfer_true THEN 1
    ELSE 0 END AS transfer_flag
  , CASE WHEN pat_enc_csn_id IN transfer_true OR death_date IS NOT NULL THEN 1
    ELSE 0 END AS decomp_flag
FROM adult_decomp_cohort