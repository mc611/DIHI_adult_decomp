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
    data_dir = '../../../../../Data/Processed/features/vitals/gap_analysis'

    flo_no_icu_freq = pd.read_csv(os.path.join(data_dir, 'flo_no_icu_freq.csv'), index_col=0)
    flo_icu_freq = pd.read_csv(os.path.join(data_dir, 'flo_icu_freq.csv'), index_col=0)
    flo_icu_freq_6hrs = pd.read_csv(os.path.join(data_dir, 'flo_icu_freq_6hrs.csv'), index_col=0)

    freq_df = gap_analysis_freq('flo_meas_name', flo_icu_freq, flo_no_icu_freq, 25290, 151923)
    freq_6hrs_df = gap_analysis_freq('flo_meas_name', flo_icu_freq_6hrs, flo_no_icu_freq, 25290, 151923)

    freq_df.to_csv(os.path.join(data_dir, 'flo_gap_analysis_freq.csv'))
    freq_6hrs_df.to_csv(os.path.join(data_dir, 'flo_gap_analysis_freq_6hrs.csv'))

    flo_no_icu_prev = pd.read_csv(os.path.join(data_dir, 'flo_no_icu_prev.csv'), usecols=['flo_meas_name', 'prev'])
    flo_icu_prev = pd.read_csv(os.path.join(data_dir, 'flo_icu_prev.csv'), usecols=['flo_meas_name', 'prev'])
    flo_icu_prev_6hrs = pd.read_csv(os.path.join(data_dir, 'flo_icu_prev_6hrs.csv'), usecols=['flo_meas_name', 'prev'])

    prev_df = gap_analysis_prev('flo_meas_name', flo_icu_prev, flo_no_icu_prev)
    prev_df_6hrs = gap_analysis_prev('flo_meas_name', flo_icu_prev_6hrs, flo_no_icu_prev)

    prev_df.to_csv(os.path.join(data_dir, 'flo_gap_analysis_prev.csv'))
    prev_df_6hrs.to_csv(os.path.join(data_dir, 'flo_gap_analysis_prev_6hrs.csv'))

if __name__ == '__main__':
    main()