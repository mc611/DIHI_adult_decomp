-- Adult Decompensation Prediction
-- 
-- Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
-- 
-- All Rights Reserved.

-- this script should be run on ../../../../Data/db/adult_decomp.db to
-- identify all encounter ids that have OR->ICU transfer
-- and outputs a csv file in ../../../../Data/Processed/outcome/or_to_icu_enc.csv

SELECT DISTINCT cohort.pat_enc_csn_id
FROM adult_decomp_cohort cohort
INNER JOIN
  (
    SELECT DISTINCT pat_enc_csn_id
    FROM adult_decomp_adt_transfer
    WHERE transfer_type = 'surgery to ICU'
  ) trans
  ON cohort.pat_enc_csn_id = trans.pat_enc_csn_id