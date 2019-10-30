# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

# pull all analytes' component name and timestamp within cohort encounters

for file in P:/dihi_qi/data_pipeline/data/numeric_analytes/*.csv
do
    file_name=$(echo $file| cut -d'/' -f 6)
    year=$(echo $file_name| cut -c1-4)
    month=$(echo $file_name| cut -c6-7)
    if ( ( [ "$year" == "2015" ] && [ "$month" -ge "10" ] ) || [ "$year" -ge "2016" ] ) ; then
        echo Now scanning file: $file
        output_file="../../../../../Data/Raw/analytes/${file_name}"
        awk -F , 'BEGIN{print "pat_enc_csn_id,component_name,order_time"}' > $output_file
        awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
        'FNR==NR{a[$2]++;next};(FNR>1)&&a[$2]{print $2, $4, $18}' \
        ../../../../../Data/Processed/cohort/cohort_enc.csv \
        $file >> $output_file
    fi
done