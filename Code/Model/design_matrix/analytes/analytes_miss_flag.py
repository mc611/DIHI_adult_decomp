# generate a design matrix which labels whether a lab value is missing and filled with a normal value
import sys
sys.path.insert(0, '../../../')

from utils.db_utils import create_connection
import pandas as pd

def main():
    db = '../../../../Data/db/adult_decomp.db'
    conn = create_connection(db)

    analytes_df = pd.read_sql('SELECT * FROM design_matrix_analytes', conn)

    analytes_miss_flag = pd.DataFrame()
    analytes_miss_flag['pat_enc_csn_id'] = analytes_df['pat_enc_csn_id']
    analytes_miss_flag['days_to_admission'] = analytes_df['days_to_admission']

    analytes_df = analytes_df.groupby('pat_enc_csn_id').ffill().reindex(analytes_df.columns, axis=1)

    analytes_miss_flag['albumin_miss_flag'] = analytes_df['albumin_avg'].isnull().astype(int)
    analytes_miss_flag['bun_miss_flag'] = analytes_df['bun_avg'].isnull().astype(int)
    analytes_miss_flag['creatinine_miss_flag'] = analytes_df['creatinine_avg'].isnull().astype(int)
    analytes_miss_flag['hct_miss_flag'] = analytes_df['hct_avg'].isnull().astype(int)
    analytes_miss_flag['inr_miss_flag'] = analytes_df['inr_avg'].isnull().astype(int)
    analytes_miss_flag['meg_miss_flag'] = analytes_df['meg_avg'].isnull().astype(int)
    analytes_miss_flag['platelets_miss_flag'] = analytes_df['platelets_avg'].isnull().astype(int)
    analytes_miss_flag['potassium_miss_flag'] = analytes_df['potassium_avg'].isnull().astype(int)
    analytes_miss_flag['sodium_miss_flag'] = analytes_df['sodium_avg'].isnull().astype(int)
    analytes_miss_flag['wbc_miss_flag'] = analytes_df['wbc_avg'].isnull().astype(int)
    analytes_miss_flag['glucose_miss_flag'] = analytes_df['glucose_avg'].isnull().astype(int)

    # store the table to database
    analytes_miss_flag.to_sql('analytes_miss_flag', conn, if_exists='replace')

    # close database connection
    conn.close()

    return None

if __name__ == '__main__':
    main()