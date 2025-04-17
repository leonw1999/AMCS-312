#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --account=s10001
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --hint=nomultithread

srun -n ${SLURM_NTASKS} --hint=nomultithread /scratch/wilkoslp/HW2/ps2
