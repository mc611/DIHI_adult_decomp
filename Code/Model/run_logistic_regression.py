import pandas as pd
from model_utils import get_data
from sklearn.linear_model import LogisticRegression

def main():
    X_train_rus, y_train_rus, X_test, y_test = get_data()

    lr_clf = LogisticRegression(random_state=0)
    lr_clf.fit(X_train_rus, y_train_rus)
    y_score = lr_clf.predict_proba(X_test)[:, 1]
    y_hat = lr_clf.predict(X_test)

    lr_scores = pd.DataFrame({'y_true': y_test, 'y_hat': y_hat, 'y_score': y_score})
    lr_scores.to_csv('../../Data/Modeling/Output/scores/logistic_regression_scores.csv')

if __name__ == '__main__':
    main()