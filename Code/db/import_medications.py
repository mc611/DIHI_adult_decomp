import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite, add_index

def main():
    db = '../../Data/db/adult_decomp.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        # add antibiotics
        csv_to_sqlite('../../Data/Processed/features/medications/antibiotics/antibiotics_cleaned.csv', conn, 'antibiotics_cleaned', index_col=0)
        add_index(conn, 'antibiotics_cleaned', 'pat_enc_csn_id')

        # add fluids
        csv_to_sqlite('../../Data/Processed/features/medications/fluids/fluids_cleaned.csv', conn, 'fluids_cleaned', index_col=0)
        add_index(conn, 'fluids_cleaned', 'pat_enc_csn_id')

        # add immunosuppresent
        csv_to_sqlite('../../Data/Processed/features/medications/immunosuppresent/immunosuppresent_cleaned.csv', conn, 'immunosuppresent_cleaned', index_col=0)
        add_index(conn, 'immunosuppresent_cleaned', 'pat_enc_csn_id')

        # add insulin
        csv_to_sqlite('../../Data/Processed/features/medications/insulin/insulin_cleaned.csv', conn, 'insulin_cleaned', index_col=0)
        add_index(conn, 'insulin_cleaned', 'pat_enc_csn_id')

        # add vasopressors
        csv_to_sqlite('../../Data/Processed/features/medications/vasopressors/vasopressors_cleaned.csv', conn, 'vasopressors_cleaned', index_col=0)
        add_index(conn, 'vasopressors_cleaned', 'pat_enc_csn_id')

    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()


if __name__ == '__main__':
    main()