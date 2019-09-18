#! /bin/bash

output_file='../../../../../Data/Processed/features/analytes/wbc/wbc.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

#create csv headers
awk -F , 'BEGIN{print "pat_id,pat_enc_csn_id,component_id,component_name,common_name,test_id,test_name,proc_id,proc_name,\
          order_name,resulting_lab_id,specimen_source,value,num_value,reference_unit,normal_lower_bound,normal_upper_bound,\
          order_time,collected_time,result_time,ordering_provider_id,ordering_provider_npi,location_id,department_name"}' >> $output_file

#put flo_meas_id in array a, pat_id in array b
for file in P:/dihi_qi/data_pipeline/data/numeric_analytes/*.csv
do
    echo Now scanning file: $file
    awk -F , 'FNR==NR{a[$1]++;next};(FNR+19)==NR{b[$1]++;next};a[$3]&&b[$1]' \
    ../../../../../Data/Processed/features/analytes/wbc/wbc_ids.csv \
    ../../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_file
done