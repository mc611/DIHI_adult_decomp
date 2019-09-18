#! /bin/bash

# This script loops through dihi flowsheet data to partition by flo meas name and get distinct patient ids for each distinct flow measurement

# a temporary output file that stores distinct patient ids for the top 115 (combined from top 100 from entire cohort and top 100 from icu admission patients)
# flow measurements, in terms of months
output_temp='../../../../Data/Processed/features/vitals/flo_distribution_temp.csv'

# remove file if existing
if [ -f $output_temp ] ; then
    rm $output_temp
fi

# create header for output file
awk -F , 'BEGIN{print "flo_meas_name,pat_id"}' >> $output_temp

# loop through dihi flowsheet data
for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    echo Now scanning file: $file
    awk -F, \
    # array a[] stores the top flo meas names, array b[] stores all patient ids, array seen[] stores distinct flo meas name combined with patient id
    'FNR==NR{a[$1]++;next};(FNR+115)==NR{b[$1]++;next};a[$3]&&b[$1]&&(!seen[$1,$3]++){print $3 "," $1}' \
    # a csv file that stores the top flo meas names
    ../../../../Data/Processed/features/vitals/flo_top.csv \
    ../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_temp
done