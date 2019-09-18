DROP TABLE IF EXISTS mortality_unit;
CREATE TABLE mortality_unit AS
SELECT cohort.pat_enc_csn_id
  , cohort.pat_id
  , cohort.death_date
  , MAX(adt.discharge_dttm) AS last_discharge_dttm
  , adt.department_name
  , adt.level_of_care
  , adt.specialty
FROM
(
  SELECT DISTINCT pat_enc_csn_id
    , pat_id
    , death_date
  FROM adult_decomp_cohort
  WHERE death_date IS NOT NULL
) cohort
INNER JOIN
(
  SELECT DISTINCT adt_events.pat_enc_csn_id
    , adt_events.adt_event_dttm AS discharge_dttm
    , adt_events.department_name
    , LU_hospital_unit.level_of_care
    , LU_hospital_unit.specialty
  FROM adt_events
  LEFT JOIN LU_hospital_unit
    ON adt_events.department_name = LU_hospital_unit.department_name
  WHERE adt_event_type = 'Discharge'
) adt
  ON cohort.pat_enc_csn_id = adt.pat_enc_csn_id
GROUP BY pat_id;