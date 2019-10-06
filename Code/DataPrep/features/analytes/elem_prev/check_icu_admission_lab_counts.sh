#! /bin/bash
# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.


output_temp='../../../../../Data/Processed/features/analytes/icu_admission_lab_counts_temp.csv'
output_file='../../../../../Data/Processed/features/analytes/icu_admission_lab_counts.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "component_name,count"}' >> $output_temp

for file in P:/dihi_qi/data_pipeline/data/numeric_analytes/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$1]{lab[$4]++}END{for (i in lab) print i, lab[i]}' \
    ../../../../../Data/Processed/cohort/icu_admission_pat_ids.csv $file >> $output_temp
done

python sum_lab_counts.py $output_temp $output_file