#! /bin/bash

#-F command should be updated to escape comma inside quotes

output_file='../../../../../Data/Processed/features/vitals/bp/bp.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

#create csv headers
awk -F , 'BEGIN{print "pat_id,pat_enc_csn_id,flo_meas_name,disp_name,val_type_name,flo_meas_id,recorded_time,meas_value"}' >> $output_file

#put flo_meas_id in array a, pat_id in array b
for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    echo Now scanning file: $file
    awk -F , 'FNR==NR{a[$1]++;next};(FNR+22)==NR{b[$1]++;next};a[$6]&&b[$1]' \
    ../../../../../Data/Processed/features/vitals/bp/bp_ids.csv \
    ../../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_file
done