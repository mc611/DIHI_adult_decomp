-- this query should be run on ../../../../Data/db/adult_decomp.db
-- and outputs a csv file in ../../../../Data/Processed/cohort/icu_admission_pat_ids.csv (remember to turn headers off)
-- to get all patient ids who have an outcome as icu admission
SELECT DISTINCT pat_id
FROM outcome
WHERE icu_admission_flag = 1;