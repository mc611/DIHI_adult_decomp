import numpy as np
import pandas as pd

def clean_icd10(icd_code):
    code_copy = str(icd_code)
    
    if code_copy == 'nan':
        return np.nan
    else:
    # remove periods in icd10 code and get first code if multiples are given
        return code_copy.replace('.', '').split(',')[0]

def main():
    diag_df = pd.read_csv('../../../../Data/Processed/features/diags/diags.csv', usecols=['pat_id', 'contact_date', 'icd10_code_edg'])
    icd_full = pd.read_csv('../../../../Data/metadata/diags/icd_ccs_full.csv')

    # drop null values
    diag_df = diag_df.dropna(subset=['icd10_code_edg'])

    diag_df['icd10_code_edg'] = diag_df['icd10_code_edg'].apply(clean_icd10)
    diag_df = diag_df.merge(icd_full, how='left', left_on='icd10_code_edg', right_on='code')

    diag_df = diag_df[['pat_id','contact_date','icd10_code_edg','category']]

    diag_df.to_csv('../../../../Data/Processed/features/diags/diags_icd10_cleaned.csv')

    return None

if __name__ == '__main__':
    main()