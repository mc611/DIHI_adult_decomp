#! /bin/bash

output_temp='../../../../Data/Processed/features/medications/mar_distribution_temp.csv'

if [ -f $output_temp ] ; then
    rm $output_temp
fi

fi

awk -F , 'BEGIN{print "medication_name,pat_id"}' >> $output_temp

for file in P:/dihi_qi/data_pipeline/data/med_administrations/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, \
    'FNR==NR{a[$1]++;next};(FNR+118)==NR{b[$1]++;next};a[$4]&&b[$2]&&(!seen[$2,$4]++){print $4, $2}' \
    ../../../../Data/Processed/features/medications/mar_top.csv \
    ../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_temp
done