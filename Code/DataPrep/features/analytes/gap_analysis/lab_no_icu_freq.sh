# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

output_file='../../../../../Data/Processed/features/analytes/gap_analysis/lab_no_icu_freq_temp.csv'

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "component_name,count"}' >> $output_file

for file in ../../../../../Data/Raw/analytes/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$1]{lab[$2]++}END{for (i in lab) print i, lab[i]}' \
    ../../../../../Data/Processed/cohort/no_icu_adm_enc.csv $file >> $output_file
done