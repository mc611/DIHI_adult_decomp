DROP TABLE IF EXISTS adult_decomp_cohort;
CREATE TABLE adult_decomp_cohort AS
WITH adt AS
(
  SELECT adt_events.pat_id
    , adt_events.pat_enc_csn_id
    , adt_events.adt_event_dttm
    , adt_events.adt_event_type
    , adt_events.department_name
    , adt_events.loc_name
    -- set the earliest adt_event time as adt_start_time
    , MIN(adt_events.adt_event_dttm)
      OVER (PARTITION BY adt_events.pat_enc_csn_id) AS adt_start_time
    , admission.hospital_admission_time
    , discharge.hospital_discharge_time
  FROM adt_events
  INNER JOIN
    -- create hospital_admission_time column and remove encounters without an admission event
    (SELECT DISTINCT pat_enc_csn_id, adt_event_dttm AS hospital_admission_time 
     FROM adt_events 
     WHERE adt_event_type='Admission') admission
    ON adt_events.pat_enc_csn_id = admission.pat_enc_csn_id
  INNER JOIN
    -- create hospital_discharge_time column and remove encounters without a discharge event
    (SELECT DISTINCT pat_enc_csn_id, adt_event_dttm AS hospital_discharge_time
     FROM adt_events
     WHERE adt_event_type='Discharge') discharge
    ON adt_events.pat_enc_csn_id = discharge.pat_enc_csn_id
  INNER JOIN
    -- within each encounter, at least one of from_base_class/to_base class = inpatient
    (SELECT DISTINCT pat_enc_csn_id
     FROM adt_events
     WHERE from_base_class = 'Inpatient' OR to_base_class = 'Inpatient') ip
    ON adt_events.pat_enc_csn_id = ip.pat_enc_csn_id
  WHERE
    -- loc_name = duh or drh or drah
    adt_events.loc_name IN ('DUKE RALEIGH HOSPITAL', 'DUKE REGIONAL HOSPITAL', 'DUKE UNIVERSITY HOSPITAL')
    -- exclude encounters with only direct transfer from ED to ICU
    AND adt_events.pat_enc_csn_id NOT IN
      (
        SELECT pat_enc_csn_id
        FROM adult_decomp_adt_transfer
        GROUP BY pat_enc_csn_id
        HAVING COUNT(*)=1
          AND transfer_type='ED to ICU'
      )
)
, pat_cleannull AS
( -- clean null values in the patient table
  SELECT pat_mrn_id
    , pat_id
    , death_date
    , birth_date
    , sex
    , hispanic
    , CASE WHEN (race = 'Unavailable' OR race ='Not Reported/Declined') THEN NULL
        ELSE race END AS race
  FROM patient
  -- exclude patients without a birth date
  WHERE birth_date IS NOT NULL
)

SELECT DISTINCT adt_enc.pat_enc_csn_id
  , adt_enc.pat_id
  , pat.pat_mrn_id
  , adt_enc.loc_name
  , adt_enc.adt_start_time
  , adt_enc.hospital_admission_time
  , adt_enc.hospital_discharge_time
  , ip_enc_distinct.admission_type
  , ip_enc_distinct.inpatient_admit_time_peh
  , ip_enc_distinct.hsp_admsn_time
  , ip_enc_distinct.discharge_time_peh
  , pat.death_date
  , pat.birth_date
  , pat.sex
  , pat.hispanic
  , pat.race
  , pat.is_white
  , pat.is_black
  -- calculate age = adt_start_time - birth_date
  , CAST((strftime('%Y.%m%d', adt_enc.adt_start_time)- strftime('%Y.%m%d', pat.birth_date)) AS int) AS age
  -- caluclate length of stay for each encounter in term of days
  , printf("%.2f", (julianday(adt_enc.hospital_discharge_time) - julianday(adt_enc.hospital_admission_time))) AS length_of_stay
FROM
  (SELECT DISTINCT pat_enc_csn_id
    , pat_id
    , loc_name
    , adt_start_time
    , hospital_admission_time
    , hospital_discharge_time
   FROM adt) adt_enc
INNER JOIN
  ( -- all patients have one distinct update date
    SELECT pat_mrn_id
      , pat_id
      , death_date
      , birth_date
      , sex
      , hispanic
    -- merge patients with multiple races entered into '2 or more races' category
      , CASE WHEN COUNT(race)>1 THEN '2 or more races'
             WHEN COUNT(*)>1 AND COUNT(race)=1 THEN MAX(race)
          ELSE race END AS race
      , CASE WHEN SUM(race='Caucasian/White')>0 THEN 1
          ELSE 0 END AS is_white
      , CASE WHEN SUM(race='Black or African American')>0 THEN 1
          ELSE 0 END AS is_black
    FROM pat_cleannull
    GROUP BY pat_id
  ) pat
  ON adt_enc.pat_id = pat.pat_id
INNER JOIN
  (
    -- drop duplicate ip encounters
    SELECT DISTINCT pat_enc_csn_id
      , admission_type
      , inpatient_admit_time_peh
      , hsp_admsn_time
      , discharge_time_peh
    FROM ip_encounter
  ) ip_enc_distinct
  ON adt_enc.pat_enc_csn_id = ip_enc_distinct.pat_enc_csn_id
-- exclude encounters less than 18 years old
WHERE adt_enc.adt_start_time >= '2015-10-01T00:00:00Z'
  AND age >= 18;