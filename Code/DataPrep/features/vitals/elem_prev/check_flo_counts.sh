#! /bin/bash

# This script uses adult decompensation cohort patient ids to loop through dihi flowsheet data
# to get total counts of each distinct flow meas name being collected

# a temporary output file to store flowsheet counts for each month
output_temp='../../../../../Data/Processed/features/vitals/flo_counts_temp.csv'

# the output file that stores flowsheet counts over the four years within cohort
output_file='../../../../../Data/Processed/features/vitals/flo_counts.csv'

#remove file if existing
if [ -f $output_temp ] ; then
    rm $output_temp
fi

if [ -f $output_file ] ; then
    rm $output_file
fi

# create header for the output file
awk -F , 'BEGIN{print "flo_meas_name,count"}' >> $output_temp

# loop through dihi vital data
# array a stores all patient ids, array flow stores the count for each distinct flow meas name
# cohort_pat_ids.csv: a file that stores cohort patient ids
for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$1]{flow[$3]++}END{for (i in flow) print i, flow[i]}' \
    ../../../../../Data/Processed/cohort/cohort_pat_ids.csv \
    $file >> $output_temp
done

# run a python script to clean flowsheet counts for each month, namely, to get aggregate counts for four years
python sum_flo_counts.py $output_temp $output_file