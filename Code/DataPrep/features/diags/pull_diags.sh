#! /bin/bash

output_file='../../../../Data/Processed/features/diags/diags.csv'

#remove output file if exists
if [ -f $output_file ] ; then
    rm $output_file
fi

#create csv headers
awk -F , 'BEGIN{print "pat_id,contact_date,pat_enc_csn_id,eff_start_date,eff_end_date,icd9_code_edg,icd10_code_edg"}' >> $output_file

for file in P:/dihi_qi/data_pipeline/data/diag/*.csv
do
    echo Now scanning file: $file
    awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'FNR==NR{a[$1]++;next};a[$1]{print $1, $3, $4, $8, $9, $12, $13}' \
    ../../../../Data/Processed/cohort/cohort_pat_ids.csv $file >> $output_file
done