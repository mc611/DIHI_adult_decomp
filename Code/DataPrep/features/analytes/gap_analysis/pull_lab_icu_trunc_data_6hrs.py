# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import os
import gc
import pandas as pd

def main():
    icu_adm_enc_6hrs_df = pd.read_csv('../../../../../Data/Processed/cohort/icu_adm_enc_6hrs.csv')
    icu_adm_enc_6hrs_df['6hrs_before_transfer'] = pd.to_datetime(icu_adm_enc_6hrs_df['6hrs_before_transfer'])
    for file_name in os.listdir('../../../../../Data/Raw/analytes'):
        file = os.path.join('../../../../../Data/Raw/analytes', file_name)
        df = pd.read_csv(file)
        df = df.merge(icu_adm_enc_6hrs_df, left_on='pat_enc_csn_id', right_on='pat_enc_csn_id', how='inner')
        df['order_time'] = pd.to_datetime(df['order_time'], errors='coerce')
        df = df.loc[df['order_time']<df['6hrs_before_transfer']]
        df = df[['pat_enc_csn_id', 'component_name']]
        df.to_csv(os.path.join('../../../../../Data/Processed/features/analytes/gap_analysis/lab_icu_trunc_data_6hrs', file_name), index=False)
        del df
        gc.collect()


if __name__ == '__main__':
    main()