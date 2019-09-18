import sys
sys.path.insert(0, '../../../')

import pandas as pd
from utils.df_utils import clean_data_element_distribution

def main():
    mar_distribution_df = pd.read_csv('../../../../Data/Processed/features/medications/mar_distribution_temp.csv')
    mar_distribution_df = mar_distribution_df.drop_duplicates()
    
    icu_admission_pat_ids = pd.read_csv('../../../../Data/Processed/cohort/icu_admission_pat_ids.csv', names=['pat_id'])
    icu_admission_mar_distribution_df = mar_distribution_df.merge(icu_admission_pat_ids, how='inner', left_on='pat_id', right_on='pat_id')

    mar_distribution_df = mar_distribution_df.groupby('medication_name')['pat_id'].count().to_frame(name='pat_count').reset_index()
    icu_admission_mar_distribution_df = icu_admission_mar_distribution_df.groupby('medication_name')['pat_id'].count().to_frame(name='icu_pat_count').reset_index()

    mar_counts = pd.read_csv('../../../../Data/Processed/features/medications/mar_counts.csv', usecols=['medication_name','count'], nrows=100)
    mar_grouper = pd.read_csv('../../../../Data/Processed/features/medications/mar_current_grouper.csv', usecols=['medication_name','grouper'])
    mar_top_100 = clean_data_element_distribution(mar_counts, 'medication_name', mar_distribution_df, icu_admission_mar_distribution_df, mar_grouper, 141277)
    mar_top_100.to_csv('../../../../Data/Processed/features/medications/mar_top_100.csv')

    icu_admission_mar_counts = pd.read_csv('../../../../Data/Processed/features/medications/icu_admission_mar_counts.csv', usecols=['medication_name','count'], nrows=100)
    icu_admission_mar_top_100 = clean_data_element_distribution(icu_admission_mar_counts, 'medication_name', mar_distribution_df, icu_admission_mar_distribution_df, mar_grouper, 141277)
    icu_admission_mar_top_100.to_csv('../../../../Data/Processed/features/medications/icu_admission_mar_top_100.csv')
    return None

if __name__ == '__main__':
    main()