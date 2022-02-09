#!/bin/bash

## Script for adding bam tracks with hubload.py
##
## Example usage:
## inDir=. trackName=nanopore trackdb=~/hub/hg38/trackDb.txt sbatch hubload_bam.sbatch

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --time=1:00:00
#SBATCH --mem=32GB

# Job name and output
#SBATCH -J hubload_bam
#SBATCH -o /scratch/Users/%u/data/slurmOut/slurm-%j.out
#SBATCH -e /scratch/Users/%u/data/slurmErr/slurm-%j.err

# commands go here
pwd; hostname; date

module load python/2.7.14

echo "TrackName: "$trackName
echo "TrackDb: "$trackdb

echo $(date +"[%b %d %H:%M:%S] Adding bam tracks to hub...")

for i in $inDir/*.bam 
do
	echo "Processing file: "$i
	hubload.py --input $i --supertrack $trackName --trackDb $trackdb
	echo $(date +"[%b %d %H:%M:%S] Done")
done

echo $(date +"[%b %d %H:%M:%S] All done!")
