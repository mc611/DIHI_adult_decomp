import sys
sys.path.insert(0, '../../../')

import pandas as pd
from utils.df_utils import clean_data_element_distribution

def main():
    lab_distribution_df = pd.read_csv('../../../../Data/Processed/features/analytes/lab_distribution_temp.csv')
    lab_distribution_df = lab_distribution_df.drop_duplicates()
    
    icu_admission_pat_ids = pd.read_csv('../../../../Data/Processed/cohort/icu_admission_pat_ids.csv', names=['pat_id'])
    icu_admission_lab_distribution_df = lab_distribution_df.merge(icu_admission_pat_ids, how='inner', left_on='pat_id', right_on='pat_id')

    lab_distribution_df = lab_distribution_df.groupby('component_name')['pat_id'].count().to_frame(name='pat_count').reset_index()
    icu_admission_lab_distribution_df = icu_admission_lab_distribution_df.groupby('component_name')['pat_id'].count().to_frame(name='icu_pat_count').reset_index()

    lab_counts = pd.read_csv('../../../../Data/Processed/features/analytes/lab_counts.csv', usecols=['component_name','count'], nrows=100)
    lab_grouper = pd.read_csv('../../../../Data/Processed/features/analytes/lab_current_grouper.csv', usecols=['component_name','grouper'])
    lab_top_100 = clean_data_element_distribution(lab_counts, 'component_name', lab_distribution_df, icu_admission_lab_distribution_df, lab_grouper, 141277)
    lab_top_100.to_csv('../../../../Data/Processed/features/analytes/lab_top_100.csv')

    icu_admission_lab_counts = pd.read_csv('../../../../Data/Processed/features/analytes/icu_admission_lab_counts.csv', usecols=['component_name','count'], nrows=100)
    icu_admission_lab_top_100 = clean_data_element_distribution(icu_admission_lab_counts, 'component_name', lab_distribution_df, icu_admission_lab_distribution_df, lab_grouper, 141277)
    icu_admission_lab_top_100.to_csv('../../../../Data/Processed/features/analytes/icu_admission_lab_top_100.csv')
    return None

if __name__ == '__main__':
    main()