# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

#! /bin/bash

for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    file_name=$(echo $file| cut -d'/' -f 6)
    year=$(echo $file_name| cut -c1-4)
    month=$(echo $file_name| cut -c6-7)
    if ( ( [ "$year" == "2015" ] && [ "$month" -ge "10" ] ) || [ "$year" -ge "2016" ] ) ; then
        output_file="../../../../../${file_name}"
        echo $output_file
    fi
done