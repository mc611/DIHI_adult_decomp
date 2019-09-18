DROP TABLE IF EXISTS design_matrix_vitals;
CREATE TABLE design_matrix_vitals AS
SELECT label.pat_enc_csn_id
  , label.days_to_admission
  , bp.systolic_bp_max
  , bp.systolic_bp_min
  , bp.systolic_bp_avg
  , bp.diastolic_bp_max
  , bp.diastolic_bp_min
  , bp.diastolic_bp_avg
  , loc.loc_non_alert
  , sup_oxy.sup_oxy_flag
  , pulse.pulse_max
  , pulse.pulse_min
  , pulse.pulse_avg
  , spo2.spo2_max
  , spo2.spo2_min
  , spo2.spo2_avg
  , resp.resp_max
  , resp.resp_min
  , resp.resp_avg
  , temp.temp_max
  , temp.temp_min
  , temp.temp_avg
  , label.icu_admission_flag
FROM design_matrix_days_label label
LEFT JOIN design_matrix_bp bp
  ON label.pat_enc_csn_id=bp.pat_enc_csn_id
  AND label.days_to_admission=bp.days_to_admission
LEFT JOIN design_matrix_loc loc
  ON label.pat_enc_csn_id=loc.pat_enc_csn_id
  AND label.days_to_admission=loc.days_to_admission
LEFT JOIN design_matrix_sup_oxy sup_oxy
  ON label.pat_enc_csn_id=sup_oxy.pat_enc_csn_id
  AND label.days_to_admission=sup_oxy.days_to_admission
LEFT JOIN design_matrix_pulse pulse
  ON label.pat_enc_csn_id=pulse.pat_enc_csn_id
  AND label.days_to_admission=pulse.days_to_admission
LEFT JOIN design_matrix_spo2 spo2
  ON label.pat_enc_csn_id=spo2.pat_enc_csn_id
  AND label.days_to_admission=spo2.days_to_admission
LEFT JOIN design_matrix_resp resp
  ON label.pat_enc_csn_id=resp.pat_enc_csn_id
  AND label.days_to_admission=resp.days_to_admission
LEFT JOIN design_matrix_temp temp
  ON label.pat_enc_csn_id=temp.pat_enc_csn_id
  AND label.days_to_admission=temp.days_to_admission;