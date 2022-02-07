#!/bin/bash

## Script for running guppy basecalling
##
## Example usage:
## inDir=./fast5 outDir=./fastq sbatch guppyBasecalling.sbatch

## General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=6:00:00
#SBATCH --mem=32GB

# Job name and output
#SBATCH -J guppy-cpu
#SBATCH -o /Users/%u/slurmOut/slurm-%j.out
#SBATCH -e /Users/%u/slurmErr/slurm-%j.err

##################################

/Shares/CL_Shared/programs/ont-guppy-cpu/bin/guppy_basecaller -c dna_r9.4.1_450bps_sup.cfg --compress_fastq -s $outDir -i $inDir --cpu_threads_per_caller 8 --num_callers 2





