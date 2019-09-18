#! /bin/bash

output_temp='../../../../Data/Processed/features/medications/icu_admission_mar_counts_temp.csv'
output_file='../../../../Data/Processed/features/medications/icu_admission_mar_counts.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

if [ -f $output_file ] ; then
    rm $output_file
fi

awk -F , 'BEGIN{print "medication_name,count"}' >> $output_temp

for file in P:/dihi_qi/data_pipeline/data/med_administrations/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR>1)&&a[$2]{mar[$4]++}END{for (i in mar) print i, mar[i]}' \
    ../../../../Data/Processed/cohort/icu_admission_pat_ids.csv $file >> $output_temp
done

python sum_mar_counts.py $output_temp $output_file