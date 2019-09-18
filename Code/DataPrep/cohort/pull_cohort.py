# This script executes the cohort sql query in Michael's database to create the cohort table
# and exports the cohort table as a csv file
import sys
sys.path.insert(0, '../../')

import sqlite3
import pandas as pd
from utils.db_utils import create_connection, create_table, export_table

def main():
    database = "P:/dihi_qi/data_pipeline/db/data_pipeline.db"
 
    cohort_qry = open('./sql/pull_cohort.sql', 'r').read()
 
    # create a database connection
    conn = create_connection(database)
    if conn is not None:
        # create adult_decomp_cohort table
        create_table(conn, cohort_qry)
    else:
        print("Error! cannot create the database connection.")
    export_table(conn, 'adult_decomp_cohort', '../../../Data/Processed/cohort/adult_decomp_cohort.csv')

    conn.close()

if __name__ == '__main__':
    main()