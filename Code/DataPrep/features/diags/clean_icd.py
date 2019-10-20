import pandas as pd
import numpy as np

def remove_period(icd_code):
    code_copy = str(icd_code)

    if code_copy == 'nan':
        return np.nan
    else:
        # remove periods in icd code
        return code_copy.replace('.', '')

def get_ith_elem(icd_code, i):
    code_copy = str(icd_code)

    if code_copy == 'nan':
        return np.nan
    else:
        # get ith code, i starts from 0
        return code_copy.split(', ')[i]

def clean_icd_df(df):
    """ 
    :param df: pandas dataframe consisting of three columns: ['pat_id', 'contact_date', 'icd_code']
               icd_code can be either icd9 or icd10
               dataframe may contain na values and duplicates
               uncleaned icd_code may contain periods, multiple codes separated by comma and space in same row
    :return: pandas dataframe with cleaned icd_code, consisting of three column: ['pat_id', 'contact_date', 'icd_code']
    """
    df = df.dropna(subset=['icd_code'])
    df['icd_code'] = df['icd_code'].apply(remove_period)
    df = df.drop_duplicates()
    df_cleaned = df[df['icd_code'].apply(lambda x: x.count(',')==0)]
    for i in range(1, 5):
        df_comma = df[df['icd_code'].apply(lambda x: x.count(',')==i)]
        for j in range(i+1):
            df_comma_separated = df_comma.copy()
            df_comma_separated['icd_code'] = df_comma_separated['icd_code'].apply(lambda x: get_ith_elem(x, j))
            df_cleaned = df_cleaned.append(df_comma_separated, ignore_index=True)
    return df_cleaned


def main():
    diags_df = pd.read_csv('../../../../Data/Processed/features/diags/diags_contact_date_modified.csv')

    df_icd9 = diags_df[['pat_id', 'contact_date', 'icd9_code_edg']]
    df_icd9 = df_icd9.rename(columns={'icd9_code_edg': 'icd_code'})
    df_icd10 = diags_df[['pat_id', 'contact_date', 'icd10_code_edg']]
    df_icd10 = df_icd10.rename(columns={'icd10_code_edg': 'icd_code'})
    df_icd9_cleaned = clean_icd_df(df_icd9)
    df_icd10_cleaned = clean_icd_df(df_icd10)
    df_icd_cleaned = df_icd9_cleaned.append(df_icd10_cleaned, ignore_index=True)
    df_icd_cleaned = df_icd_cleaned.drop_duplicates()

    df_icd_cleaned.to_csv('../../../../Data/Processed/features/diags/diags_icd_cleaned.csv')


if __name__ == '__main__':
    main()