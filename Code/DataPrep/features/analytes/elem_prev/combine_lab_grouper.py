# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

# combine all analytes groupers into one csv file

import glob
import pandas as pd

def main():
    files = glob.glob("P:/dihi_qi/data_pipeline/metadata/component_grouping/data/groupers/*.csv")
    # exclude undesired files
    files = list(filter(lambda x: 'sepsis' not in x and 'temp_and_weight_units_by_flo_meas_name' not in x, files))

    df_list = [pd.read_csv(f) for f in files]
    df = pd.concat(df_list, ignore_index=True)
    df = df.rename(columns = {'COMPONENT_NAME': 'component_name', 'LAB_GROUPERS': 'grouper'})
    df = df[['component_name', 'grouper']]
    df = df.drop_duplicates()

    df.to_csv('../../../../../Data/Processed/features/analytes/lab_current_grouper.csv', index=False)

if __name__ == '__main__':
    main()