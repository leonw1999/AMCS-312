#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --account=s10001
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --ntasks=192
#SBATCH --hint=nomultithread

srun -n ${SLURM_NTASKS} --hint=nomultithread /scratch/<username>/path/to/ps2/binary -da_grid_x 1024 -da_grid_y 1024
