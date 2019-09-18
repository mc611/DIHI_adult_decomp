import pandas as pd

def sum_count(input_file, output_file, data_element_name, encoding=None):
    """ sum all months' data element counts
    :param input_file: a temp csv file created by awk command, which stores data element counts by each month
    :param output_file: output csv file
    :param data_element_name: the column of data element name to group by
    :param encoding: the encoding of the input csv file
    :return:
    """
    df = pd.read_csv(input_file, encoding=encoding)
    df_sum = df.groupby(data_element_name)['count'].sum().reset_index()
    df_sort = df_sum.sort_values(by='count', ascending=False).reset_index(drop=True)
    df_sort.to_csv(output_file)
    return None

def clean_data_element_distribution(data_counts, data_element_name, data_distribution_df, outcome_data_distribution_df, grouper, cohort_count):
    '''
    :param data_counts: dataframe that stores the data element counts
    :param data_element_name: string of data element name
    :param data_distribution_df: the dataframe that stores the data element names and corresponding patient counts
    :param outcome_data_distribution_df: the dataframe that stores the data element names and corresponding patient counts, who have an outcome
    :param grouper : dataframe that stores current data element grouper
    :param cohort_count: total count of patients in cohort
    '''
    top_100 = data_counts.merge(data_distribution_df, how='left', left_on=data_element_name, right_on=data_element_name)
    top_100 = top_100.merge(outcome_data_distribution_df, how='left', left_on=data_element_name, right_on=data_element_name)

    top_100['pat_count/cohort_pat_count'] = top_100['pat_count'] / cohort_count
    top_100['icu_pat_count/pat_count'] = top_100['icu_pat_count'] / top_100['pat_count']
    top_100 = top_100.merge(grouper, how='left', left_on=data_element_name, right_on=data_element_name)
    top_100 = top_100.rename(columns = {'grouper':'current_grouper'})
    return top_100