import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite, add_index

def main():
    db = '../../Data/db/adult_decomp.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        csv_to_sqlite('../../Data/Processed/features/diags/diags_icd10_cleaned.csv', conn, 'diags_icd10_cleaned', index_col=0)
        add_index(conn, 'diags_icd10_cleaned', 'pat_id')

    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()


if __name__ == '__main__':
    main()