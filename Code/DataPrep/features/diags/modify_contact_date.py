# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

# This scripts replaces contact date in diags data with hospital admission time for all inpatient encounters,
# for all outpatient encounters, original contact dates are reserved.

import pandas as pd

def main():
    ip_enc_adm = pd.read_csv('../../../../Data/Raw/ip_encounter/ip_enc_adm.csv')
    diags = pd.read_csv('../../../../Data/Processed/features/diags/diags.csv')

    diags = diags.merge(ip_enc_adm, left_on='pat_enc_csn_id', right_on='pat_enc_csn_id', how='left')
    diags['hsp_admsn_time'] = diags['hsp_admsn_time'].fillna(diags['contact_date'])
    diags = diags[['pat_id', 'pat_enc_csn_id', 'icd9_code_edg', 'icd10_code_edg', 'hsp_admsn_time']]
    diags = diags.rename(columns={'hsp_admsn_time': 'contact_date'})

    diags.to_csv('../../../../Data/Processed/features/diags/diags_contact_date_modified.csv', index=False)

if __name__ == '__main__':
    main()