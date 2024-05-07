<<<<<<< HEAD
# Nextflow_Exercise
=======
<<<<<<< HEAD
# Nextflow_Exercise
=======
# Nextflow exercise 

This nextflow script performs read cleaning, genome assembly, assembly quality assessment, and bacterial genome characterization. 

#### Prerequisites:

#### Create a conda environment with the following tools installed:

```
conda create -n nextflow_env -y
```

#### Activate the conda environment:

conda activate nextflow_env

#### Installing all the necessary tools:

```
conda install -c bioconda -c conda-forge skesa fastp mlst quast nextflow -y
```

#### Run the nextflow script as following (change the path of reads to your own reads):

```
nextflow run main_test1.nf --inputR1 ./SRR3215024_1.fastq.gz --inputR2 ./SRR3215024_2.fastq.gz 
```
>>>>>>> 0e579ac (added all the files)
>>>>>>> a9ad725 (adding files)
