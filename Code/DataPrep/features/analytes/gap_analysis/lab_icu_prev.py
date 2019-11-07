# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import sys
sys.path.insert(0, '../../../../')

from utils.df_utils import clean_data_element_prev
import pandas as pd

def main():
    prev_df = pd.read_csv('../../../../../Data/Processed/features/analytes/gap_analysis/lab_icu_prev_temp.csv')
    prev_df = clean_data_element_prev('component_name', prev_df, 6550)
    prev_df.to_csv('../../../../../Data/Processed/features/analytes/gap_analysis/lab_icu_prev.csv')

if __name__ == '__main__':
    main()