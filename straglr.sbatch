#!/bin/bash

## Script for testing straglr
##
## Example usage:
## inDir=. outDir=. sbatch --array 0-10 straglr.sbatch

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

# define query bam files
queries=($(ls $inDir/*.bam | xargs -n 1 basename))

# load modules
module load ncbi-blast
module load bedtools/2.28.0 
module load python/3.7.4

# run the thing
pwd; hostname; date

echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

python3 straglr.py ${inDir}/${queries[$SLURM_ARRAY_TASK_ID]} /Shares/CL_Shared/db/genomes/hg38/fa/hg38.main.fa ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]%.run2.bam} --min_str_len 4 --nprocs 8 --min_ins_size 4

echo $(date +"[%b %d %H:%M:%S] Done!")

