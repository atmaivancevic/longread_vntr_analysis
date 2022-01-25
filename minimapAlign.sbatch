#!/bin/bash

## Script for aligning long-read bams
##
## Example usage:
## inDir=. outDir=. sbatch --array 0-1 minimapAlign.sbatch

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=6:00:00
#SBATCH --mem=64GB

# Job name and output
#SBATCH -J minimap2
#SBATCH -o /Users/%u/slurmOut/slurm-%A_%a.out
#SBATCH -e /Users/%u/slurmErr/slurm-%A_%a.err

module load minimap2/2.17
module load samtools

# Set query files
queries=($(ls $inDir/*.fastq.gz | xargs -n 1 basename))

# Run minimap2
minimap2 -a -x map-ont -t 4 \
/Shares/CL_Shared/db/genomes/hg38/fa/hg38.main.fa \
$inDir/${queries[$SLURM_ARRAY_TASK_ID]} \
| samtools view -bS - \
| samtools sort - -o $inDir/${queries[$SLURM_ARRAY_TASK_ID]%.fastq.gz}.sorted.bam
