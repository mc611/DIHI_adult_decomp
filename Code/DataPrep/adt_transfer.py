# This script executes the adt transfer sql query in Michael's database to create the transfer table
# and exports the table as a csv file
import sys
sys.path.insert(0, '../')

import sqlite3
import pandas as pd
from utils.db_utils import create_connection, create_table, export_table

def main():
    database = "P:/dihi_qi/data_pipeline/db/data_pipeline.db"
 
    transfer_qry = open('./adt_transfer.sql', 'r').read()
 
    # create a database connection
    conn = create_connection(database)
    if conn is not None:
        # create adult_decomp_adt_transfer table
        create_table(conn, transfer_qry)
    else:
        print("Error! cannot create the database connection.")
    #export the table to a csv file
    export_table(conn, 'adult_decomp_adt_transfer', '../../Data/Processed/adult_decomp_adt_transfer.csv')

    conn.close()

if __name__ == '__main__':
    main()