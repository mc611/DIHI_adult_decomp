# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

output_temp='../../../../../Data/Processed/features/vitals/gap_analysis/flo_no_icu_prev_temp.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

awk -F , 'BEGIN{print "flo_meas_name,pat_enc_csn_id"}' >> $output_temp

for file in ../../../../../Data/Raw/vitals/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$1]&&(!seen[$1,$2]++){print $2, $1}' \
    ../../../../../Data/Processed/cohort/no_icu_adm_enc.csv $file >> $output_temp
done