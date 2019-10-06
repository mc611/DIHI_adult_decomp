#! /bin/bash

#This script uses patients who have an outcome (ICU admission) in adult decompensation cohort, to get total counts for each flow meas name
#Please reference comments in ./check_flo_counts.sh

output_temp='../../../../../Data/Processed/features/vitals/icu_admission_flo_counts_temp.csv'
output_file='../../../../../Data/Processed/features/vitals/icu_admission_flo_counts.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "flo_meas_name,count"}' >> $output_temp

for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$1]{flow[$3]++}END{for (i in flow) print i, flow[i]}' \
    ../../../../../Data/Processed/cohort/icu_admission_pat_ids.csv $file >> $output_temp
done

python sum_flo_counts.py $output_temp $output_file