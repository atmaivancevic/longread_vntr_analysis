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

python3 straglr.py /path/to/bam/BAMFILENAME /Shares/CL_Shared/db/genomes/hg38/fa/hg38.main.fa test_output 
