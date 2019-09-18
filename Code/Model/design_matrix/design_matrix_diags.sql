DROP TABLE IF EXISTS design_matrix_diags;
CREATE TABLE design_matrix_diags AS
WITH diag AS
(
  SELECT adm.pat_enc_csn_id
    , MAX(CASE WHEN icd.category IN 
            ('Diabetes mellitus with complications','Diabetes mellitus without complication','Diabetes or abnormal glucose tolerance complicating pregnancy; childbirth; or the puerperium')
            THEN 1 ELSE 0 END) AS diabetes_flag
    , MAX(CASE WHEN icd.category IN ('Secondary malignancies','Maglignant neoplasm without specification of site') THEN 1
            ELSE 0 END) AS malignancy_flag
    , MAX(CASE WHEN icd.category = 'Chronic kidney disease' THEN 1
            ELSE 0 END) AS ckd_flag
    , MAX(CASE WHEN icd.category = 'Chronic obstructive pulmonary disease and bronchiectasis' THEN 1
            ELSE 0 END) AS copd_flag
    , MAX(CASE WHEN icd.category = 'Acute myocardial infarction' THEN 1
            ELSE 0 END) AS mi_flag
    , MAX(CASE WHEN icd.category = 'HIV infection' THEN 1
            ELSE 0 END) AS hiv_flag
  FROM cohort_admission adm
  LEFT JOIN diags_icd10_cleaned icd
    ON adm.pat_id=icd.pat_id
  WHERE adm.hospital_admission_time > icd.contact_date
  GROUP BY adm.pat_enc_csn_id
)
SELECT label.pat_enc_csn_id
  , label.days_to_admission
  , COALESCE(diag.diabetes_flag, 0) AS diabetes_flag
  , COALESCE(diag.malignancy_flag, 0) AS malignancy_flag
  , COALESCE(diag.ckd_flag, 0) AS ckd_flag
  , COALESCE(diag.copd_flag, 0) AS copd_flag
  , COALESCE(diag.mi_flag, 0) AS mi_flag
  , COALESCE(diag.hiv_flag, 0) AS hiv_flag
  , label.icu_admission_flag
FROM design_matrix_days_label label
LEFT JOIN diag
  ON label.pat_enc_csn_id=diag.pat_enc_csn_id;