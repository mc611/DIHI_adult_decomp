import sys
sys.path.insert(0, '../../')

from utils.db_utils import create_connection, create_table, export_table

def main():
    database = "../../../Data/db/adult_decomp.db"
 
    outcome_qry = open('./outcome_1st_icu_admission.sql', 'r').read()
 
    # create a database connection
    conn = create_connection(database)
    if conn is not None:
        # create adult_decomp_cohort table
        create_table(conn, outcome_qry)
    else:
        print("Error! cannot create the database connection.")
    export_table(conn, 'outcome_1st_icu_admission', '../../../Data/Processed/outcome/outcome_1st_icu_admission.csv')

    conn.close()

if __name__ == '__main__':
    main()