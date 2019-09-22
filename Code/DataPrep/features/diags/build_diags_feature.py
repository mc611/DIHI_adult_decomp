import pandas as pd
import numpy as np

def build_diags_features(enc_diags_df, icd_df, lower_bound, upper_bound):
    """
    :param enc_diags_df: dataframe consisting of columns: ['pat_enc_csn_id', 'hospital_admission_time', 'contact_date', 'icd_code']
    :param icd_df: icd mapping dataframe consisting of columns: ['code', 'category']
    :param lower_bound: least number of days between contact date and hospital admission time
    :param upper_bound: max number of days between contact date and hospital admission time
    :return: diags feature dataframe in which rows are indexed by pat_enc_csn_ids and columns are indexed by 282 comorbidity categories
    """
    diags_df = enc_diags_df.loc[((enc_diags_df['hospital_admission_time'] - enc_diags_df['contact_date']).dt.days >= lower_bound)
                                & ((enc_diags_df['hospital_admission_time'] - enc_diags_df['contact_date']).dt.days < upper_bound)]
    diags_df = diags_df[['pat_enc_csn_id', 'icd_code']]
    diags_df = diags_df.drop_duplicates()
    diags_df = diags_df.merge(icd_df, how='left', left_on='icd_code', right_on='code')
    diags_df = diags_df[['pat_enc_csn_id', 'category']]
    diags_df = diags_df.dropna(subset=['category'])
    diags_df = diags_df.drop_duplicates()
    diags_df = diags_df.groupby(['pat_enc_csn_id', 'category']).size().unstack()
    diags_df = diags_df.replace(np.nan, 0)
    diags_df = diags_df.astype(bool).astype(int)
    diags_df = diags_df.reset_index()
    diags_df.columns.names = [None]
    
    return diags_df

def main():
    icd_cleaned_df = pd.read_csv('../../../../Data/Processed/features/diags/diags_icd_cleaned.csv', index_col=0)
    icd_df = pd.read_csv('../../../../Data/metadata/diags/icd_ccs_full.csv')
    enc_df = pd.read_csv('../../../../Data/Processed/cohort/cohort_enc.csv', index_col=0)

    enc_diags_df = enc_df.merge(icd_cleaned_df, how='left', left_on='pat_id', right_on='pat_id')
    enc_diags_df = enc_diags_df[['pat_enc_csn_id', 'hospital_admission_time', 'contact_date', 'icd_code']]
    enc_diags_df = enc_diags_df.loc[enc_diags_df['hospital_admission_time'] > enc_diags_df['contact_date']]

    enc_diags_df['hospital_admission_time'] = pd.to_datetime(enc_diags_df['hospital_admission_time'])
    enc_diags_df['contact_date'] = pd.to_datetime(enc_diags_df['contact_date'])

    diags_3mon = build_diags_features(enc_diags_df, icd_df, 0, 90)
    diags_3to12mon = build_diags_features(enc_diags_df, icd_df, 90, 365)
    diags_1yr = build_diags_features(enc_diags_df, icd_df, 0, 365)

    diags_3mon.to_csv('../../../../Data/Processed/features/diags/diags_3mon.csv', index=False)
    diags_3to12mon.to_csv('../../../../Data/Processed/features/diags/diags_3to12mon.csv', index=False)
    diags_1yr.to_csv('../../../../Data/Processed/features/diags/diags_1yr.csv', index=False)


if __name__ == '__main__':
    main()