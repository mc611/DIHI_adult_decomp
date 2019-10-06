-- this script should be run on P:/dihi_qi/data_pipeline/db/data_pipeline.db
-- and outputs a csv file in ../../../Data/Raw/ip_encounter/ip_enc_adm.csv
-- pull all ip encounters' hospital admission time
SELECT DISTINCT pat_enc_csn_id
  , hsp_admsn_time
FROM ip_encounter