import sys
import pandas as pd
import ast
import math
import os

def process_line(line):
    l_data = line.split('\t')
    file_id, file_path, sample_type = l_data[0], os.path.join(sys.argv[3],l_data[0],l_data[1]), l_data[-1].strip()
    
    # Check if relevant sample type
    if sample_type not in (sys.argv[2]).split(','):
        return None, None,None
    
    # Try to load only relevant columns for memory efficiency
    try:
        temp_df = pd.read_csv(file_path, sep='\t', skiprows=1, usecols=['gene_name', 'tpm_unstranded'])
        tpm = temp_df.loc[temp_df['gene_name'] == sys.argv[1], 'tpm_unstranded'].values
        if len(tpm) > 0:
            return file_id, tpm[0],sample_type
    except FileNotFoundError:
        return None, None,None  # File not found, skip

    return None, None,None

for i in (sys.argv[2]).split(','):
    globals()[i.replace(" ","")] = {}


# Process each line, skipping header
header = True
for line in sys.stdin:
    if header:
        header = False
        continue
    #print(line)
    file_id, tpm,sample_type = process_line(line)
    if file_id:
        globals()[sample_type.replace(" ","")][file_id] = math.log2(float(tpm)+1)


for i in (sys.argv[2]).split(','):
    pd.DataFrame(globals()[i.replace(" ","")].items(), columns=['file_id', 'tpm']).to_csv(i.replace(" ","")+"_tpm.tsv", sep='\t', index=False)