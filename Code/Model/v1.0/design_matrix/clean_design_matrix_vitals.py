# fill missing values in vital design matrix
import sys
sys.path.insert(0, '../../')

from utils.db_utils import create_connection
import pandas as pd

def main():
    db = '../../../Data/db/adult_decomp.db'
    conn = create_connection(db)

    vital_df = pd.read_sql('SELECT * FROM design_matrix_vitals', conn)

    # fill missing values in loc and sup oxy wirh 0
    vital_df = vital_df.fillna(value={'loc_non_alert':0, 'sup_oxy_flag':0})

    # fill first day's missing values with a normal vital value
    vital_df.loc[(vital_df['systolic_bp_max'].isnull()) & (vital_df['days_to_admission']==1), ['systolic_bp_max', 'systolic_bp_min', 'systolic_bp_avg']]=120
    vital_df.loc[(vital_df['diastolic_bp_max'].isnull()) & (vital_df['days_to_admission']==1), ['diastolic_bp_max', 'diastolic_bp_min', 'diastolic_bp_avg']]=80
    vital_df.loc[(vital_df['pulse_max'].isnull()) & (vital_df['days_to_admission']==1), ['pulse_max', 'pulse_min', 'pulse_avg']]=80
    vital_df.loc[(vital_df['spo2_max'].isnull()) & (vital_df['days_to_admission']==1), ['spo2_max', 'spo2_min', 'spo2_avg']]=96
    vital_df.loc[(vital_df['resp_max'].isnull()) & (vital_df['days_to_admission']==1), ['resp_max', 'resp_min', 'resp_avg']]=16
    vital_df.loc[(vital_df['temp_max'].isnull()) & (vital_df['days_to_admission']==1), ['temp_max', 'temp_min', 'temp_avg']]=37

    # fill remaining missing values with the value collected last day
    vital_df = vital_df.groupby('pat_enc_csn_id').ffill().reindex(vital_df.columns, axis=1)

    # store the table to database
    vital_df.to_sql('design_matrix_vitals_cleaned', conn, if_exists='replace')

    # close database connection
    conn.close()

    return None

if __name__ == '__main__':
    main()