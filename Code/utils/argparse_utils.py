# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

import argparse

def elem_prev_argparse():
	parser=argparse.ArgumentParser(description="""Generate data elements distribution throughout the cohort.""")
	parser.add_argument('--top_num', type=int, default=100, help="The number of top data elements that are expected to checked. Maximum value allowed is 100. (default=100)")
	parser.add_argument('--cohort_count', type=int, default=111932, help="Total count of patients in cohort. (default=111932)")
	return parser.parse_args()