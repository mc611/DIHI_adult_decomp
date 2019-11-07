-- Adult Decompensation Prediction
-- 
-- Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
-- 
-- All Rights Reserved.

-- this query should be run on ../../../../Data/db/adult_decomp.db
-- and outputs a csv file in ../../../../Data/Processed/cohort/no_icu_adm_enc.csv
-- to get all pat encounter ids which DO NOT have an outcome as icu admission

SELECT DISTINCT pat_enc_csn_id
FROM outcome_1st_unplanned_icu_adm
WHERE icu_admission_label = 0;