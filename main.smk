import pandas as pd

metadata_df = pd.read_csv('metadata/metadata.tsv',sep='\t')
#print(metadata_df)
metadata_df=metadata_df.set_index('name')

genes = metadata_df.loc['gene','value']
conditions=metadata_df.loc['conditions','value']
gdc_sample_file = metadata_df.loc['gdc_sample_file','value']
tcga_data_directory= metadata_df.loc['tcga_data_directory','value']


rule get_tpm:
    input:
    params:
        genes = genes,
        conditions=conditions,
        gdc_sample_file=gdc_sample_file,
        tcga_data_directory=tcga_data_directory,
    output: 
        output_format = "{type}_tpm.tsv"
    shell:
        "cat {params.gdc_sample_file} | python get_tpm.py {params.genes} {params.conditions} {params.tcga_data_directory}"

rule plot:
    input:
        a = [ i.replace(" ","")[1:-1] +"_tpm.tsv" for i in conditions.split(',')]
    params:
        files_to_plot = conditions
    output: 
        output_format = "ggplots/plot_stn_pt.pdf"
    shell:
        "Rscript plot.R {params.files_to_plot}"