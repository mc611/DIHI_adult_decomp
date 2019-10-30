# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

output_file='../../../../../Data/Processed/features/medications/gap_analysis/mar_icu_freq_6hrs_temp.csv'

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "medication_name,count"}' >> $output_file

for file in ../../../../../Data/Processed/features/medications/gap_analysis/mar_icu_trunc_data_6hrs/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    '(FNR>1){mar[$2]++}END{for (i in mar) print i, mar[i]}' \
    $file >> $output_file
done