-- This script extracts all the transfer events from the adt events raw data, and categorize these events 
DROP TABLE IF EXISTS adult_decomp_adt_transfer;
CREATE TABLE adult_decomp_adt_transfer AS
-- create an intermediate table which stores all transfer events' in-out departments
WITH transfer_in_out AS
(
  SELECT pat_id
    , pat_enc_csn_id
    , adt_event_type
    , adt_event_dttm
    , FIRST_VALUE(department_name) OVER (PARTITION BY pat_enc_csn_id, adt_event_dttm ORDER BY adt_event_type) AS transfer_in_dep
    , FIRST_VALUE(department_name) OVER (PARTITION BY pat_enc_csn_id, adt_event_dttm ORDER BY adt_event_type DESC) AS transfer_out_dep
  FROM adt_events
  WHERE adt_event_type='Transfer In'
    OR adt_event_type='Transfer Out'
)
-- add in-out departments' level of care for all transfer events
, transfer_in_out_2 AS
(
  SELECT pat_id
    , pat_enc_csn_id
    , adt_event_dttm AS transfer_dttm
    , transfer_out_dep
    , transfer_in_dep
  FROM transfer_in_out
  -- exclude transfers with the same department name
  WHERE transfer_in_dep <> transfer_out_dep
  GROUP BY pat_enc_csn_id, adt_event_dttm
)
, transfer_units AS
(
  SELECT trans.pat_id
    , trans.pat_enc_csn_id
    , trans.transfer_dttm
    , trans.transfer_out_dep
    , trans_out.level_of_care AS transfer_out_level_of_care
    , trans_out.specialty AS transfer_out_specialty
    , trans.transfer_in_dep
    , trans_in.level_of_care AS transfer_in_level_of_care
    , trans_in.specialty AS transfer_in_specialty
  FROM transfer_in_out_2 AS trans
  LEFT JOIN ad_hospital_units AS trans_out
    ON trans.transfer_out_dep = trans_out.department_name
  LEFT JOIN ad_hospital_units AS trans_in
    ON trans.transfer_in_dep = trans_in.department_name
  WHERE trans.transfer_dttm >= trans_out.start_dttm
    AND trans.transfer_dttm <= trans_out.end_dttm
    AND trans.transfer_dttm >= trans_in.start_dttm
    AND trans.transfer_dttm <= trans_in.end_dttm
)
-- categorize all transfer types
SELECT pat_id
  , pat_enc_csn_id
  , transfer_dttm
  , transfer_out_dep
  , transfer_out_level_of_care
  , transfer_out_specialty
  , transfer_in_dep
  , transfer_in_level_of_care
  , transfer_in_specialty
  , CASE WHEN transfer_out_specialty='emergency' AND transfer_in_level_of_care='intensive care' THEN 'ED to ICU'
         WHEN transfer_out_level_of_care='regular' AND (transfer_out_specialty<>'emergency' OR transfer_out_specialty IS NULL) AND transfer_in_level_of_care='intensive care' THEN 'floor to ICU'
         WHEN transfer_out_level_of_care='stepdown' AND transfer_in_level_of_care='intensive care' THEN 'stepdown to ICU'
         WHEN transfer_out_level_of_care='regular' AND (transfer_out_specialty<>'emergency' OR transfer_out_specialty IS NULL) AND transfer_in_level_of_care='stepdown' THEN 'floor to stepdown'
         WHEN transfer_out_level_of_care='intensive care' AND transfer_in_level_of_care='regular' AND (transfer_in_specialty<>'emergency' OR transfer_in_specialty IS NULL) THEN 'ICU to floor'
         WHEN transfer_out_level_of_care='intensive care' AND transfer_in_level_of_care='stepdown' THEN 'ICU to stepdown'
         WHEN transfer_out_level_of_care='stepdown' AND transfer_in_level_of_care='regular' AND (transfer_in_level_of_care<>'emergency' OR transfer_in_specialty IS NULL) THEN 'stepdown to floor'
      ELSE 'Other' END AS transfer_type
FROM transfer_units;