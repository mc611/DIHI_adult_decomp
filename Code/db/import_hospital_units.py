# This script imports adult decompensation hospital units into
# Michael's database in datapipeline folder

import sys
sys.path.insert(0, '../')

from utils.db_utils import create_connection, csv_to_sqlite

def main():
    db = '../../../../../db/data_pipeline.db'
    
    # create a database connection
    conn = create_connection(db)

    if conn is not None:
        # add ad_hospital_units
        csv_to_sqlite('../../Data/metadata/hospital_unit/ad_hospital_units.csv', conn, 'ad_hospital_units')
    else:
        print("Error! cannot create the database connection.")

    # close database connection
    conn.close()

if __name__ == '__main__':
    main()