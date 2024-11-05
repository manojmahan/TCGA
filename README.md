# TCGA
### Download and extract the data
```
mkdir data/
cd data/
curl -JLO "https://figshare.com/ndownloader/files/49476642?private_link=fd7276e3583b457bd61d"
curl -JLO "https://figshare.com/ndownloader/files/49623507?private_link=fd7276e3583b457bd61d"
curl -JLO "https://figshare.com/ndownloader/files/49623510?private_link=fd7276e3583b457bd61d"
tar -zxvf tcga_data.tar.gz
cd ../
```
### Edit the metadata.tsv as per the requirements
### run snakemake

```
snakemake --snakefile main.smk ggplots/plot_stn_pt.pdf -j1
```

 
