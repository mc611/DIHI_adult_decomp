DROP TABLE IF EXISTS design_matrix_demographic;
CREATE TABLE design_matrix_demographic AS
SELECT label.pat_enc_csn_id
  , label.days_to_admission
  , demographic.age
  , demographic.is_male
  , demographic.race_is_white
  , demographic.race_is_black
  , demographic.race_other
  , label.icu_admission_flag
FROM design_matrix_days_label label
LEFT JOIN
(
  SELECT DISTINCT pat_enc_csn_id
    , age
    , CASE WHEN sex='Male' THEN 1
        ELSE 0 END AS is_male
    , is_white AS race_is_white
    , is_black AS race_is_black
    , CASE WHEN is_white=0 AND is_black=0 THEN 1
        ELSE 0 END AS race_other
  FROM adult_decomp_cohort
) demographic
  ON label.pat_enc_csn_id=demographic.pat_enc_csn_id