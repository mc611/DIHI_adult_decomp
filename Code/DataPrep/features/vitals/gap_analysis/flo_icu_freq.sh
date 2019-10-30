# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

output_file='../../../../../Data/Processed/features/vitals/gap_analysis/flo_icu_freq_temp.csv'

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "flo_meas_name,count"}' >> $output_file

for file in ../../../../../Data/Processed/features/vitals/gap_analysis/flo_icu_trunc_data/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    '(FNR>1){flo[$2]++}END{for (i in flo) print i, flo[i]}' \
    $file >> $output_file
done