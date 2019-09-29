import sqlite3
import pandas as pd
from News.news import run_news

def main():
    conn = sqlite3.connect('../../Data/db/adult_decomp.db')
    
    vital_df = pd.read_sql('SELECT * FROM design_matrix_vitals_cleaned', conn)

    X = vital_df[['resp_avg','spo2_avg','sup_oxy_flag','systolic_bp_avg','pulse_avg','temp_avg','loc_non_alert']].values
    y = vital_df['icu_admission_flag'].values

    y_score, y_hat = run_news(X, threshold=5)

    news_scores = pd.DataFrame({'y_true': y, 'y_hat': y_hat, 'y_score': y_score})
    news_scores.to_csv('../../Data/Modeling/Output/scores/news_scores.csv')

if __name__ == '__main__':
    main()