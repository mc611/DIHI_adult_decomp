-- Adult Decompensation Prediction
--
-- Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
-- 
-- All Rights Reserved.

-- This script should be run on ../../../../Data/db/adult_decomp.db
-- to create a table outcome_1st_unplanned_icu_adm, which labels each encounter with unplanned ICU transfer flag
-- and corresponding 1st unplanned ICU admission timestamp
-- output a csv file in ../../../../Data/Processed/outcome/out_1st_unplanned_icu_adm.csv

DROP TABLE IF EXISTS outcome_1st_unplanned_icu_adm;
CREATE TABLE outcome_1st_unplanned_icu_adm AS
WITH trans AS
(
  SELECT pat_enc_csn_id
    , MIN(transfer_dttm) AS transfer_dttm
  FROM adult_decomp_adt_transfer
  WHERE transfer_type in ('floor to ICU', 'stepdown to ICU')
  GROUP BY pat_enc_csn_id
)
SELECT DISTINCT cohort.pat_enc_csn_id
  , cohort.pat_id
  , trans.transfer_dttm
  , CASE WHEN transfer_dttm IS NOT NULL THEN 1
      ELSE 0 END AS icu_admission_label
FROM adult_decomp_cohort cohort
LEFT JOIN trans
  ON cohort.pat_enc_csn_id=trans.pat_enc_csn_id;