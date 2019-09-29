import sqlite3
import pandas as pd
import numpy as np
from model_utils import get_data
import xgboost as xgb
from sklearn.model_selection import GridSearchCV

def main():
    X_train_rus, y_train_rus, X_test, y_test = get_data()

    clf_xgb = xgb.XGBClassifier()
    '''
    parameters = {'eta': [0.3],
                  'max_depth': [8],
                  'min_child_weight': [5],
                  'gamma': [0.2],
                  'colsample_bytree': [1],
                  'objective': ['binary:logistic']}
    '''
    parameters = {'eta': [0.1, 0.15, 0.2, 0.25, 0.3, 0.35],
                  'max_depth': [3, 4, 5, 6, 7, 8, 10, 12],
                  'min_child_weight': [1, 3, 5, 7],
                  'gamma': [0, 0.1, 0.2, 0.3, 0.4],
                  'colsample_bytree': [0.5, 0.7, 1],
                  'objective': ['binary:logistic']}
    
    grid = GridSearchCV(clf_xgb, parameters, n_jobs=4, scoring='average_precision', cv=2, verbose=5)
    best_params = grid.fit(X_train_rus, y_train_rus).best_params_

    D_train = xgb.DMatrix(X_train_rus, label=y_train_rus)
    D_test = xgb.DMatrix(X_test, label=y_test)
    clf_xgb = xgb.train(best_params, D_train, 20)
    y_score = clf_xgb.predict(D_test)
    #y_hat = np.asarray([np.argmax(line) for line in y_score])
    y_hat = y_score.copy()
    y_hat[y_hat<0.5]=0
    y_hat[y_hat>=0.5]=1

    xgb_scores = pd.DataFrame({'y_true': y_test, 'y_hat': y_hat, 'y_score': y_score})
    xgb_scores.to_csv('../../Data/Modeling/Output/scores/xgb_scores.csv')

if __name__ == '__main__':
    main()