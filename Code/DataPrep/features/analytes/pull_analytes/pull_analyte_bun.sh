# Adult Decompensation Prediction
# 
# Copyright 2019 Ziyuan Shen, Duke Institute for Health Innovation (DIHI), Duke University School of Medicine, Durham NC.
# 
# All Rights Reserved.

grouper_file='P:/dihi_qi/data_pipeline/metadata/component_grouping/data/groupers/BUN_10_1_2014_8_1_2018.csv'
output_file='../../../../../Data/Processed/features/analytes/bun/bun.csv'
cohort_pat_id='../../../../../Data/Processed/cohort/cohort_pat_ids.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

# store number of lines in the grouper file into variable NUM
NUM=$(awk 'END{print NR}' $grouper_file)

#create csv headers
awk -F , 'BEGIN{print "pat_id,pat_enc_csn_id,component_id,component_name,common_name,test_id,test_name,proc_id,proc_name,\
          order_name,resulting_lab_id,specimen_source,value,num_value,reference_unit,normal_lower_bound,normal_upper_bound,\
          order_time,collected_time,result_time,ordering_provider_id,ordering_provider_npi,location_id,department_name"}' >> $output_file

#put component name in array a, pat_id in array b
for file in P:/dihi_qi/data_pipeline/data/numeric_analytes/*.csv
do
    echo Now scanning file: $file
    awk -F , -v num=$NUM 'FNR==NR{a[$2]++;next};(FNR+num)==NR{b[$1]++;next};a[$4]&&b[$1]' \
    $grouper_file $cohort_pat_id $file >> $output_file
done