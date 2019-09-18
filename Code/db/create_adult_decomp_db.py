# This script imports cohort and transfer data into adult_decomp.db to initialize a sqlite database for adult decompensation
import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite, add_index

def main():
    db = '../../Data/db/adult_decomp.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        # add cohort table
        csv_to_sqlite('../../Data/Processed/cohort/adult_decomp_cohort.csv', conn, 'adult_decomp_cohort', index_col=0)
        add_index(conn, 'adult_decomp_cohort', 'pat_enc_csn_id')

        # add transfer table
        csv_to_sqlite('../../Data/Processed/adult_decomp_adt_transfer.csv', conn, 'adult_decomp_adt_transfer', index_col=0)
        add_index(conn, 'adult_decomp_adt_transfer', 'pat_enc_csn_id')
    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()


if __name__ == '__main__':
    main()