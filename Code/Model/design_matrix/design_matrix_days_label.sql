-- This query uses icu admission information from design_matrix_label table(which labels each encounter with icu admission)
-- to label each day during hospital stay before icu admission or discharge with icu admission next day
DROP TABLE IF EXISTS design_matrix_days_label;
CREATE TABLE design_matrix_days_label AS
WITH temp AS
(
  SELECT pat_enc_csn_id
    , max_days_to_admission
  FROM design_matrix_label
  WHERE max_days_to_admission > 1
    AND max_days_to_admission <= 30
)
, temp2 AS
(
  SELECT pat_enc_csn_id
    , max_days_to_admission
    , (max_days_to_admission - 2) AS i
  FROM temp
  UNION ALL
  SELECT pat_enc_csn_id
    , max_days_to_admission
    , (i - 1) AS i
  FROM temp2
  WHERE i>0
)
SELECT pat_enc_csn_id
  , days_to_admission
  , CASE WHEN icu_admission_label=1 AND days_to_admission=(max_days_to_admission-1) THEN 1
      ELSE 0 END AS icu_admission_flag
FROM
(
  SELECT temp2.pat_enc_csn_id
    , temp2.max_days_to_admission
    , ROW_NUMBER() OVER (PARTITION BY temp2.pat_enc_csn_id) AS days_to_admission
    , label.icu_admission_label
  FROM temp2
  LEFT JOIN design_matrix_label label
    ON temp2.pat_enc_csn_id=label.pat_enc_csn_id
);
-- create index on encounter id
CREATE INDEX idx_design_matrix_days_label ON design_matrix_days_label(pat_enc_csn_id);