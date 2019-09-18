import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite, add_index

def main():
    db = '../../Data/db/adult_decomp.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        # add albumin
        print('Now importing albumin')
        csv_to_sqlite('../../Data/Processed/features/analytes/albumin/albumin_cleaned.csv', conn, 'albumin_cleaned', index_col=0)
        add_index(conn, 'albumin_cleaned', 'pat_enc_csn_id')

        # add bandemia
        print('Now importing bandemia')
        csv_to_sqlite('../../Data/Processed/features/analytes/bandemia/bandemia_cleaned.csv', conn, 'bandemia_cleaned', index_col=0)
        add_index(conn, 'bandemia_cleaned', 'pat_enc_csn_id')

        # add bun
        print('Now importing bun')
        csv_to_sqlite('../../Data/Processed/features/analytes/bun/bun_cleaned.csv', conn, 'bun_cleaned', index_col=0)
        add_index(conn, 'bun_cleaned', 'pat_enc_csn_id')

        # add creatinine
        print('Now importing creatinine')
        csv_to_sqlite('../../Data/Processed/features/analytes/creatinine/creatinine_cleaned.csv', conn, 'creatinine_cleaned', index_col=0)
        add_index(conn, 'creatinine_cleaned', 'pat_enc_csn_id')

        # add glucose
        print('Now importing glucose')
        csv_to_sqlite('../../Data/Processed/features/analytes/glucose/glucose_cleaned.csv', conn, 'glucose_cleaned', index_col=0)
        add_index(conn, 'glucose_cleaned', 'pat_enc_csn_id')

        # add hct
        print('Now importing hct')
        csv_to_sqlite('../../Data/Processed/features/analytes/hct/hct_cleaned.csv', conn, 'hct_cleaned', index_col=0)
        add_index(conn, 'hct_cleaned', 'pat_enc_csn_id')

        # add inr
        print('Now importing inr')
        csv_to_sqlite('../../Data/Processed/features/analytes/inr/inr_cleaned.csv', conn, 'inr_cleaned', index_col=0)
        add_index(conn, 'inr_cleaned', 'pat_enc_csn_id')

        # add lactate
        print('Now importing lactate')
        csv_to_sqlite('../../Data/Processed/features/analytes/lactate/lactate_cleaned.csv', conn, 'lactate_cleaned', index_col=0)
        add_index(conn, 'lactate_cleaned', 'pat_enc_csn_id')

        # add meg
        print('Now importing meg')
        csv_to_sqlite('../../Data/Processed/features/analytes/meg/meg_cleaned.csv', conn, 'meg_cleaned', index_col=0)
        add_index(conn, 'meg_cleaned', 'pat_enc_csn_id')

        # add pco2
        print('Now importing pco2')
        csv_to_sqlite('../../Data/Processed/features/analytes/pco2/pco2_cleaned.csv', conn, 'pco2_cleaned', index_col=0)
        add_index(conn, 'pco2_cleaned', 'pat_enc_csn_id')

        # add ph
        print('Now importing ph')
        csv_to_sqlite('../../Data/Processed/features/analytes/ph/ph_cleaned.csv', conn, 'ph_cleaned', index_col=0)
        add_index(conn, 'ph_cleaned', 'pat_enc_csn_id')

        # add platelets
        print('Now importing platelets')
        csv_to_sqlite('../../Data/Processed/features/analytes/platelets/platelets_cleaned.csv', conn, 'platelets_cleaned', index_col=0)
        add_index(conn, 'platelets_cleaned', 'pat_enc_csn_id')

        # add po2
        print('Now importing po2')
        csv_to_sqlite('../../Data/Processed/features/analytes/po2/po2_cleaned.csv', conn, 'po2_cleaned', index_col=0)
        add_index(conn, 'po2_cleaned', 'pat_enc_csn_id')

        # add potassium
        print('Now importing potassium')
        csv_to_sqlite('../../Data/Processed/features/analytes/potassium/potassium_cleaned.csv', conn, 'potassium_cleaned', index_col=0)
        add_index(conn, 'potassium_cleaned', 'pat_enc_csn_id')

        # add sodium
        print('Now importing sodium')
        csv_to_sqlite('../../Data/Processed/features/analytes/sodium/sodium_cleaned.csv', conn, 'sodium_cleaned', index_col=0)
        add_index(conn, 'sodium_cleaned', 'pat_enc_csn_id')

        # add trop
        print('Now importing trop')
        csv_to_sqlite('../../Data/Processed/features/analytes/trop/trop_cleaned.csv', conn, 'trop_cleaned', index_col=0)
        add_index(conn, 'trop_cleaned', 'pat_enc_csn_id')

        # add wbc
        print('Now importing wbc')
        csv_to_sqlite('../../Data/Processed/features/analytes/wbc/wbc_cleaned.csv', conn, 'wbc_cleaned', index_col=0)
        add_index(conn, 'wbc_cleaned', 'pat_enc_csn_id')

    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()


if __name__ == '__main__':
    main()