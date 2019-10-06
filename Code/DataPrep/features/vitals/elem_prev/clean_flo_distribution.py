# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import sys
sys.path.insert(0, '../../../../')

import pandas as pd
from utils.df_utils import clean_data_element_distribution
from utils.argparse_utils import elem_prev_argparse

def main():
    '''
	args={'top_num', 'cohort_count'}
	'''
    args = elem_prev_argparse()

    # temporary file created by ./check_flo_distribution.sh, which stores distinct patient ids for top flo meas names
    flo_distribution_df = pd.read_csv('../../../../../Data/Processed/features/vitals/flo_distribution_temp.csv')
    # drop all duplicates
    flo_distribution_df = flo_distribution_df.drop_duplicates()
    
    # file that stores patient ids with an outcome (ICU admission)
    icu_admission_pat_ids = pd.read_csv('../../../../../Data/Processed/cohort/icu_admission_pat_ids.csv', names=['pat_id'])
    # subset the dataframe using patients with an outcome
    icu_admission_flo_distribution_df = flo_distribution_df.merge(icu_admission_pat_ids, how='inner', left_on='pat_id', right_on='pat_id')

    # get the count of distint patients for each flo meas name
    flo_distribution_df = flo_distribution_df.groupby('flo_meas_name')['pat_id'].count().to_frame(name='pat_count').reset_index()
    icu_admission_flo_distribution_df = icu_admission_flo_distribution_df.groupby('flo_meas_name')['pat_id'].count().to_frame(name='icu_pat_count').reset_index()

    # read in the top 100 flo meas name for entire cohort, with their counts
    flo_counts = pd.read_csv('../../../../../Data/Processed/features/vitals/flo_counts.csv', usecols=['flo_meas_name','count'], nrows=args.top_num)
    # read in the current grouper
    flo_grouper = pd.read_csv('../../../../../Data/Processed/features/vitals/flo_current_grouper.csv', usecols=['flo_meas_name','grouper'])
    # get prevalence, distribution percentage etc for the top 100 flo meas names
    flo_top_100 = clean_data_element_distribution(flo_counts, 'flo_meas_name', flo_distribution_df, icu_admission_flo_distribution_df, flo_grouper, args.cohort_count)
    # store output to a csv file
    flo_top_100.to_csv('../../../../../Data/Processed/features/vitals/flo_top_100.csv')

    # read in the top 100 flo meas name for patients with an outcome
    icu_admission_flo_counts = pd.read_csv('../../../../../Data/Processed/features/vitals/icu_admission_flo_counts.csv', usecols=['flo_meas_name','count'], nrows=args.top_num)
    icu_admission_flo_top_100 = clean_data_element_distribution(icu_admission_flo_counts, 'flo_meas_name', flo_distribution_df, icu_admission_flo_distribution_df, flo_grouper, args.cohort_count)
    icu_admission_flo_top_100.to_csv('../../../../../Data/Processed/features/vitals/icu_admission_flo_top_100.csv')
    return None

if __name__ == '__main__':
    main()