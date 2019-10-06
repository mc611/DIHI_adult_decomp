# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

# pull cohort oxygen flow rate data from raw data

grouper_file='P:/dihi_qi/data_pipeline/metadata/vitals_grouping/data/groupers/Oxygen_Flow_Rate.csv'
output_file='../../../../../Data/Processed/features/vitals/oxygen_flow_rate/oxygen_flow_rate.csv'
cohort_pat_id='../../../../../Data/Processed/cohort/cohort_pat_ids.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

# store number of lines in the grouper file into variable NUM
NUM=$(awk 'END{print NR}' $grouper_file)

#create csv headers
awk -F , 'BEGIN{print "pat_id,pat_enc_csn_id,flo_meas_name,disp_name,val_type_name,flo_meas_id,recorded_time,meas_value"}' >> $output_file

#put flo_meas_name in array a, pat_id in array b
for file in P:/dihi_qi/data_pipeline/data/vitals/*.csv
do
    echo Now scanning file: $file
    awk -F , -v num=$NUM 'FNR==NR{a[$1]++;next};(FNR+num)==NR{b[$1]++;next};a[$3]&&b[$1]' \
    $grouper_file $cohort_pat_id $file >> $output_file
done