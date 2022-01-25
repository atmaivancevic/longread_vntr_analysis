#!/bin/bash

## Example usage:
## sbatch --array 0-24 sraDownload.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --time=24:00:00
#SBATCH --mem=64GB

# Job name and output
#SBATCH -J sraDownload
#SBATCH -o /Users/%u/slurmOut/slurm-%A_%a.out
#SBATCH -e /Users/%u/slurmErr/slurm-%A_%a.err

# load modules
module load sra

# set query files
queries=($(cat sra.txt))

# run the thing
pwd; hostname; date

echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}
echo $(date +"[%b %d %H:%M:%S] Downloading sra...")

fastq-dump --split-files --gzip ${queries[$SLURM_ARRAY_TASK_ID]}

echo $(date +"[%b %d %H:%M:%S] Done!")


# Note: contents of sra.txt should be the SRA numbers, e.g:
#
# SRR13155956
# SRR13155957
# SRR13155958
# SRR13155959
