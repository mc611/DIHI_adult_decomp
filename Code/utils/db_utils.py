import sqlite3
from sqlite3 import Error
import pandas as pd

def create_connection(db_file):
    """ create a database connection to the SQLite database specified by db_file
    :param db_file: database file
    :return: Connection object or None
    """
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except Error as e:
        print(e)
    return None

def normalize_column_name(name):
    """ replaces spaces with underscores and lowercases names"""
    name = name.replace(" ", "_")
    name = name.lower()
    return name

def csv_to_sqlite(file, conn, table_name, encoding=None, index_col=None):
    """ add a csv file to sqlite database
    :param file: csv file path and name
    :param conn: database connection object
    :param table_name: table name in database
    :param encoding: encoding sting of the csv file
    :return: None
    """
    print('Now reading: ' + file)
    df = pd.read_csv(file, encoding=encoding, index_col=index_col)
    df.columns = [normalize_column_name(x) for x in df.columns]
    print('Now importing: ' + file)
    df.to_sql(table_name, conn, if_exists='replace')
    return None

def add_index(conn, table_name, column_name):
    """ add index to a specified column of a table
    :param conn: database connection object
    :param table_name: table name
    :param column name: name of the column to add index to
    :return: None
    """
    sql = 'CREATE INDEX idx_{} ON {}({});'.format(table_name, table_name, column_name)
    try:
        c = conn.cursor()
        print('Now adding index to ' + table_name)
        c.execute(sql)
        conn.commit()
        c.close()
    except Error as e:
        print(e)

    return None

def create_table(conn, create_table_sql):
    """ create a table from the create_table_sql statement
    :param conn: Connection object
    :param create_table_sql: a CREATE TABLE statement
    :return:
    """
    try:
        c = conn.cursor()
        c.executescript(create_table_sql)
        conn.commit()
        c.close()
    except Error as e:
        print(e)

def export_table(conn, table_name, path):
    """
    export tables to csv files

    parameters:
    conn: connection object
    table_name: name of table to be exported
    path: directory to store exported files

    returns:
    None
    """
    df = pd.read_sql("SELECT * FROM {}".format(table_name), conn)
    df.to_csv(path)
    return None