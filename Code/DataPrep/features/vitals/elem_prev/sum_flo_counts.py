import sys
sys.path.insert(0, '../../../../')

from utils.df_utils import sum_count

def main():
    sum_count(sys.argv[1], sys.argv[2], 'flo_meas_name')
    return None

if __name__ == '__main__':
    main()