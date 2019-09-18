# fill missing values in vital design matrix
import sys
sys.path.insert(0, '../../')

from utils.db_utils import create_connection
import pandas as pd

def main():
    db = '../../../Data/db/adult_decomp.db'
    conn = create_connection(db)

    analytes_df = pd.read_sql('SELECT * FROM design_matrix_analytes', conn)

    # fill first day's missing values with a normal value
    analytes_df.loc[(analytes_df['albumin_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'albumin_avg']=4
    analytes_df.loc[(analytes_df['bun_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'bun_avg']=14
    analytes_df.loc[(analytes_df['creatinine_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'creatinine_avg']=1
    analytes_df.loc[(analytes_df['hct_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'hct_avg']=40
    analytes_df.loc[(analytes_df['inr_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'inr_avg']=1.4
    analytes_df.loc[(analytes_df['meg_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'meg_avg']=2.2
    analytes_df.loc[(analytes_df['platelets_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'platelets_avg']=250
    analytes_df.loc[(analytes_df['potassium_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'potassium_avg']=4.2
    analytes_df.loc[(analytes_df['sodium_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'sodium_avg']=140
    analytes_df.loc[(analytes_df['wbc_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'wbc_avg']=7.5
    analytes_df.loc[(analytes_df['glucose_avg'].isnull()) & (analytes_df['days_to_admission']==1), 'glucose_avg']=100

    # fill remaining missing values with the value collected last day
    analytes_df = analytes_df.groupby('pat_enc_csn_id').ffill().reindex(analytes_df.columns, axis=1)

    # store the table to database
    analytes_df.to_sql('design_matrix_analytes_cleaned', conn, if_exists='replace')

    # close database connection
    conn.close()

    return None

if __name__ == '__main__':
    main()