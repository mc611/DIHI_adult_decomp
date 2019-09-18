#! /bin/bash

output_file='../../../../../Data/Processed/features/medications/vasopressors/vasopressors.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

#create csv headers
awk -F , 'BEGIN{print "pat_enc_csn_id,pat_id,order_med_id,medication_name,taken_time,mar_time_source_name,mar_action_name,\
          sig,dose_unit_name,route_name,infusion_rate,mar_inf_rate_unit_name,mar_duration,duration_unit,department_name"}' >> $output_file

#put flo_meas_id in array a, pat_id in array b
for file in P:/dihi_qi/data_pipeline/data/med_administrations/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'FNR==NR{a[$1]++;next};(FNR+48)==NR{b[$1]++;next};a[$4]&&b[$2]' \
    ../../../../../Data/Processed/features/medications/vasopressors/vasopressors_names.csv \
    ../../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_file
done