#! /bin/bash
# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.


output_temp='../../../../../Data/Processed/features/analytes/lab_distribution_temp.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

awk -F , 'BEGIN{print "component_name,pat_id"}' >> $output_temp

for file in P:/dihi_qi/data_pipeline/data/numeric_analytes/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR+200)==NR{b[$1]++;next};a[$4]&&b[$1]&&(!seen[$1,$4]++){print $4, $1}' \
    ../../../../../Data/Processed/features/analytes/lab_top_names.csv \
    ../../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_temp
done