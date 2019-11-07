-- Adult Decompensation Prediction
-- 
-- Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
-- 
-- All Rights Reserved.

-- this query should be run on ../../../../Data/db/adult_decomp.db
-- and outputs a csv file in ../../../../Data/Processed/cohort/icu_adm_enc.csv
-- to get all pat encounter ids which have an outcome as icu admission, along with the first transfer's timestamp

SELECT DISTINCT pat_enc_csn_id
  , transfer_dttm
FROM outcome_1st_unplanned_icu_adm
WHERE icu_admission_label = 1;