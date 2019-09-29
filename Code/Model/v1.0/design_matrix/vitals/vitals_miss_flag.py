# generate a design matrix which labels whether a vital sign is missing and filled with a normal value
import sys
sys.path.insert(0, '../../../')

from utils.db_utils import create_connection
import pandas as pd

def main():
    db = '../../../../Data/db/adult_decomp.db'
    conn = create_connection(db)

    vital_df = pd.read_sql('SELECT * FROM design_matrix_vitals', conn)

    vitals_miss_flag = pd.DataFrame()
    vitals_miss_flag['pat_enc_csn_id'] = vital_df['pat_enc_csn_id']
    vitals_miss_flag['days_to_admission'] = vital_df['days_to_admission']

    vitals_miss_flag['loc_miss_flag'] = vital_df['loc_non_alert'].isnull().astype(int)
    vitals_miss_flag['sup_oxy_miss_flag'] = vital_df['sup_oxy_flag'].isnull().astype(int)

    vital_df = vital_df.groupby('pat_enc_csn_id').ffill().reindex(vital_df.columns, axis=1)

    vitals_miss_flag['systolic_bp_miss_flag'] = vital_df['systolic_bp_max'].isnull().astype(int)
    vitals_miss_flag['diastolic_bp_miss_flag'] = vital_df['diastolic_bp_max'].isnull().astype(int)
    vitals_miss_flag['pulse_miss_flag'] = vital_df['pulse_max'].isnull().astype(int)
    vitals_miss_flag['spo2_miss_flag'] = vital_df['spo2_max'].isnull().astype(int)
    vitals_miss_flag['resp_miss_flag'] = vital_df['resp_max'].isnull().astype(int)
    vitals_miss_flag['temp_miss_flag'] = vital_df['temp_max'].isnull().astype(int)

    # store the table to database
    vitals_miss_flag.to_sql('vitals_miss_flag', conn, if_exists='replace')

    # close database connection
    conn.close()

    return None

if __name__ == '__main__':
    main()