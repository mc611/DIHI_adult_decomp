# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import os
import sys

sys.path.insert(0, '../../../../')

from utils.df_utils import gap_analysis_freq, gap_analysis_prev
import pandas as pd

def main():
    data_dir = '../../../../../Data/Processed/features/medications/gap_analysis'

    mar_no_icu_freq = pd.read_csv(os.path.join(data_dir, 'mar_no_icu_freq.csv'), index_col=0)
    mar_icu_freq = pd.read_csv(os.path.join(data_dir, 'mar_icu_freq.csv'), index_col=0)
    mar_icu_freq_6hrs = pd.read_csv(os.path.join(data_dir, 'mar_icu_freq_6hrs.csv'), index_col=0)

    freq_df = gap_analysis_freq('medication_name', mar_icu_freq, mar_no_icu_freq, 25290, 151923)
    freq_6hrs_df = gap_analysis_freq('medication_name', mar_icu_freq_6hrs, mar_no_icu_freq, 25290, 151923)

    freq_df.to_csv(os.path.join(data_dir, 'mar_gap_analysis_freq.csv'))
    freq_6hrs_df.to_csv(os.path.join(data_dir, 'mar_gap_analysis_freq_6hrs.csv'))

    mar_no_icu_prev = pd.read_csv(os.path.join(data_dir, 'mar_no_icu_prev.csv'), usecols=['medication_name', 'prev'])
    mar_icu_prev = pd.read_csv(os.path.join(data_dir, 'mar_icu_prev.csv'), usecols=['medication_name', 'prev'])
    mar_icu_prev_6hrs = pd.read_csv(os.path.join(data_dir, 'mar_icu_prev_6hrs.csv'), usecols=['medication_name', 'prev'])

    prev_df = gap_analysis_prev('medication_name', mar_icu_prev, mar_no_icu_prev)
    prev_df_6hrs = gap_analysis_prev('medication_name', mar_icu_prev_6hrs, mar_no_icu_prev)

    prev_df.to_csv(os.path.join(data_dir, 'mar_gap_analysis_prev.csv'))
    prev_df_6hrs.to_csv(os.path.join(data_dir, 'mar_gap_analysis_prev_6hrs.csv'))

if __name__ == '__main__':
    main()