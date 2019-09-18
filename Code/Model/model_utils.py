import sqlite3
import pandas as pd
from imblearn.under_sampling import RandomUnderSampler
from sklearn.model_selection import train_test_split


def get_data(test_size=0.3, random_state=0):
    conn = sqlite3.connect('../../Data/db/adult_decomp.db')
    
    design_matrix = pd.read_sql('SELECT * FROM design_matrix_full', conn)
    X = design_matrix.iloc[:, 2:68].values
    y = design_matrix['icu_admission_flag'].values

    rus = RandomUnderSampler(random_state=random_state)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size, random_state=random_state)
    X_train_rus, y_train_rus = rus.fit_resample(X_train, y_train)

    return X_train_rus, y_train_rus, X_test, y_test