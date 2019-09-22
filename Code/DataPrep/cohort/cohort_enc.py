import sys
sys.path.insert(0, '../../')

import sqlite3
import pandas as pd
from utils.db_utils import create_connection, create_table, add_index, export_table

def main():
    database = "../../../Data/db/adult_decomp.db"
 
    qry = open('./sql/cohort_enc.sql', 'r').read()
 
    # create a database connection
    conn = create_connection(database)
    if conn is not None:
        create_table(conn, qry)
        add_index(conn, 'cohort_enc', 'pat_enc_csn_id')
    else:
        print("Error! cannot create the database connection.")
    export_table(conn, 'cohort_enc', '../../../Data/Processed/cohort/cohort_enc.csv')

    conn.close()

if __name__ == '__main__':
    main()