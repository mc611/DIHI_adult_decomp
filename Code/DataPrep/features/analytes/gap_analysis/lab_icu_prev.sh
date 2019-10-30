# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

output_temp='../../../../../Data/Processed/features/analytes/gap_analysis/lab_icu_prev_temp.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

awk -F , 'BEGIN{print "component_name,pat_enc_csn_id"}' >> $output_temp

for file in ../../../../../Data/Processed/features/analytes/gap_analysis/lab_icu_trunc_data/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    '(FNR>1)&&(!seen[$1,$2]++){print $2, $1}' \
    $file >> $output_temp
done