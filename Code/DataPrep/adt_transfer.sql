-- Adult Decompensation Prediction
--
-- Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
--
-- All Rights Reserved.

-- This script extracts all the transfer events from the adt events raw data, and categorize these events

DROP TABLE IF EXISTS adult_decomp_adt_transfer;
CREATE TABLE adult_decomp_adt_transfer AS
-- categorize hospital departments into ED, floor, stepdown, surgery and ICU
WITH hospital_units AS
(
  SELECT department_name
    , level_of_care
    , specialty
    , start_dttm
    , end_dttm
    , CASE WHEN level_of_care='intensive care' THEN 'ICU'
           WHEN specialty='emergency' THEN 'ED'
           WHEN specialty='surgery' THEN 'surgery'
           WHEN level_of_care='regular' AND ((specialty<>'emergency' AND specialty<>'surgery') OR specialty IS NULL) THEN 'floor'
           WHEN level_of_care='stepdown' AND (specialty<>'surgery' OR specialty IS NULL) THEN 'stepdown'
        ELSE 'Other' END AS unit_category
  FROM ad_hospital_units
)
-- create an intermediate table which stores all transfer events' in-out departments
, transfer_in_out AS
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
    , trans_out.unit_category as transfer_out_unit_category
    , trans.transfer_in_dep
    , trans_in.level_of_care AS transfer_in_level_of_care
    , trans_in.specialty AS transfer_in_specialty
    , trans_in.unit_category AS transfer_in_unit_category
  FROM transfer_in_out_2 AS trans
  LEFT JOIN hospital_units AS trans_out
    ON trans.transfer_out_dep = trans_out.department_name
  LEFT JOIN hospital_units AS trans_in
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
  , transfer_out_unit_category || ' to ' || transfer_in_unit_category AS transfer_type
FROM transfer_units;