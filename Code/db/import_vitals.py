import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite, add_index

def main():
    db = '../../Data/db/adult_decomp.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        # add bp
        csv_to_sqlite('../../Data/Processed/features/vitals/bp/bp_cleaned.csv', conn, 'bp_cleaned', index_col=0)
        add_index(conn, 'bp_cleaned', 'pat_enc_csn_id')

        # add level of consciousness
        csv_to_sqlite('../../Data/Processed/features/vitals/level_of_consciousness/level_of_consciousness_cleaned.csv', \
            conn, 'level_of_consciousness_cleaned', index_col=0)
        add_index(conn, 'level_of_consciousness_cleaned', 'pat_enc_csn_id')

        # add supplemental oxygen
        csv_to_sqlite('../../Data/Processed/features/vitals/O2/O2.csv', conn, 'O2', index_col=0)
        add_index(conn, 'O2', 'pat_enc_csn_id')

        # add pulse
        csv_to_sqlite('../../Data/Processed/features/vitals/pulse/pulse_cleaned.csv', conn, 'pulse_cleaned')
        add_index(conn, 'pulse_cleaned', 'pat_enc_csn_id')

        # add spo2
        csv_to_sqlite('../../Data/Processed/features/vitals/pulse_oximetry/pulse_oximetry_cleaned.csv', conn, 'pulse_oximetry_cleaned', index_col=0)
        add_index(conn, 'pulse_oximetry_cleaned', 'pat_enc_csn_id')

        # add respiratory rate
        csv_to_sqlite('../../Data/Processed/features/vitals/respiratory_rate/respiratory_rate_cleaned.csv', conn, 'respiratory_rate_cleaned', index_col=0)
        add_index(conn, 'respiratory_rate_cleaned', 'pat_enc_csn_id')

        # add temperature
        csv_to_sqlite('../../Data/Processed/features/vitals/temperature/temperature_cleaned.csv', conn, 'temperature_cleaned', index_col=0)
        add_index(conn, 'temperature_cleaned', 'pat_enc_csn_id')
    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()


if __name__ == '__main__':
    main()