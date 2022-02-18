#!/bin/bash

## Script for testing straglr
##
## Example usage:
## sbatch straglr.sbatch

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=6:00:00
#SBATCH --mem=64GB

# Job name and output
#SBATCH -J straglr
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# run this script from the straglr directory

module load ncbi-blast
module load bedtools/2.28.0 
module load python/3.7.4

python3 straglr.py /Shares/CL_Shared/data/olivia/National_Cancer_Institute/SRR5951586_1.sorted.bam /Shares/CL_Shared/db/genomes/hg38/fa/hg38.main.fa test_output --min_str_len 6 --max_str_len 14 --chroms 5 --nprocs 8 --min_ins_size 30
