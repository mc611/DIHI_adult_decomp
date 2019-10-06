# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import sys
sys.path.insert(0, '../../../../')

from utils.df_utils import sum_count

def main():
    sum_count(sys.argv[1], sys.argv[2], 'component_name', "ISO-8859-1")
    return None

if __name__ == '__main__':
    main()