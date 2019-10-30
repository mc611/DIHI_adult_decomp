# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

# subtract 6 hours from 1st ICU admission time stamp

import pandas as pd

def main():
    icu_adm_enc_df = pd.read_csv('../../../Data/Processed/cohort/icu_adm_enc.csv')
    icu_adm_enc_df['6hrs_before_transfer'] = pd.to_datetime(icu_adm_enc_df['transfer_dttm']) - pd.Timedelta(hours=6)
    icu_adm_enc_df = icu_adm_enc_df[['pat_enc_csn_id', '6hrs_before_transfer']]
    icu_adm_enc_df.to_csv('../../../Data/Processed/cohort/icu_adm_enc_6hrs.csv', index = False)

if __name__ == '__main__':
    main()