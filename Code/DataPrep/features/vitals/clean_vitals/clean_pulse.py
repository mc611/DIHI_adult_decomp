import pandas as pd

def main():
    pulse_df = pd.read_csv('../../../../../Data/Processed/features/vitals/pulse/pulse.csv')
    pulse_df['meas_value'] = pd.to_numeric(pulse_df['meas_value'], errors='coerce')
    
    # drop null values (there are 72194 null values in the column meas value)
    pulse_df = pulse_df.dropna()

    # remove values out of range
    pulse_df = pulse_df.loc[(pulse_df['meas_value']>=20) & (pulse_df['meas_value']<=300), :]

    pulse_df = pulse_df.loc[(pulse_df['flo_meas_name']=='PULSE') | (pulse_df['flo_meas_name']=='R DUHS PULSE RATE'), :]

    pulse_df.to_csv('../../../../../Data/Processed/features/vitals/pulse/pulse_cleaned.csv', index=False)

if __name__ == '__main__':
    main()