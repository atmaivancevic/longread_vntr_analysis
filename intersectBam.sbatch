#!/bin/bash

## Example usage:
## sbatch --array 0-24 intersectBam.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=12:00:00
#SBATCH --mem=32GB

# Job name and output
#SBATCH -J intersect_bam
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%A_%a.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%A_%a.err

# load modules
module load bedtools
module load samtools

# define query files
queries=($(ls *.sorted.bam | xargs -n 1 basename))

# run the thing
pwd; hostname; date

echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}

bedtools intersect -abam ${queries[$SLURM_ARRAY_TASK_ID]} -b LTR10_merged.bed > ${queries[$SLURM_ARRAY_TASK_ID]%.sorted.bam}_intersect_LTR10.bam

# Create a bai index file
samtools index ${queries[$SLURM_ARRAY_TASK_ID]%.sorted.bam}_intersect_LTR10.bam

echo $(date +"[%b %d %H:%M:%S] Done!")
