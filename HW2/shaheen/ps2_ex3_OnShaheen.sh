#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --account=s10001
#SBATCH --partition=workq
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --hint=nomultithread

LOGFILE="HW2_results_ex3.txt"

rm -f "$LOGFILE"
rm -f "matrix_1D.mtx"
rm -f "matrix_2D.mtx"
rm -f "matrix_3D.mtx"
rm -f "matrix_2D_cond1.mtx"
rm -f "matrix_2D_cond2.mtx"
rm -f "matrix_2D_cond3.mtx"
rm -f "matrix_2D_cond4.mtx"
rm -f "matrix_2D_cond5.mtx"

# Ex3 Part 1
echo -e "\n\n############# Ex3 Part 1 ###############\n\n" | tee -a "$LOGFILE"

echo -e "\n\n############# 1D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-1D -ksp_view 2>&1 | tee -a "$LOGFILE"

echo -e "\n\n############# 2D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -ksp_view 2>&1 | tee -a "$LOGFILE"

echo -e "\n\n############# 3D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -ksp_view 2>&1 | tee -a "$LOGFILE"

# Ex3 Part 2
echo -e "\n\n############# Ex3 Part 2 ###############\n\n" | tee -a "$LOGFILE"

echo -e "\n\n############# 1D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-1D -da_grid_x 16 -log_view -ksp_monitor -ksp_error_if_not_converged 2>&1 | tee -a "$LOGFILE"

echo -e "\n\n############# 2D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 16 -da_grid_y 16 -log_view -ksp_monitor -ksp_error_if_not_converged 2>&1 | tee -a "$LOGFILE"

echo -e "\n\n############# 3D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 16 -da_grid_y 16 -da_grid_z 16 -log_view -ksp_monitor -ksp_error_if_not_converged 2>&1 | tee -a "$LOGFILE"

# Ex3 Part 3
echo -e "\n\n############# Ex3 Part 3 ###############\n\n" | tee -a "$LOGFILE"

echo -e "\n\n############# 1D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-1D -da_grid_x 9 -matrix

echo -e "\n\n############# 2D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 9 -da_grid_y 9 -matrix

echo -e "\n\n############# 3D ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 9 -da_grid_y 9 -da_grid_z 9 -matrix

# Ex3 Part 4
echo -e "\n\n############# Ex3 Part 4 ###############\n\n" | tee -a "$LOGFILE"

srun -n 1 --hint=nomultithread ps2-1D -da_grid_x 16 -ksp_monitor -ksp_error_if_not_converged 2>&1 | tee -a "$LOGFILE"

# Ex3 Part 5
echo -e "\n\n############# Ex3 Part 5 ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -ksp_monitor -ksp_view_eigenvalues 2>&1 | tee -a "$LOGFILE"

# Ex3 Part 6 and 7
echo -e "\n\n############# Ex3 Part 6 and 7 ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 9 -da_grid_y 9 -ksp_monitor -ksp_compute_eigenvalues  2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 17 -da_grid_y 17 -ksp_monitor -ksp_compute_eigenvalues 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 33 -da_grid_y 33 -ksp_monitor -ksp_compute_eigenvalues 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 65 -da_grid_y 65 -ksp_monitor -ksp_compute_eigenvalues 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-2D -da_grid_x 129 -da_grid_y 129 -ksp_monitor -ksp_compute_eigenvalues 2>&1 | tee -a "$LOGFILE"

# Ex3 Part 8
echo -e "\n\n############# Ex3 Part 8 ###############\n\n" | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 9 -da_grid_y 9 -da_grid_z 9 -ksp_monitor -ksp_rtol 1e-1 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 9 -da_grid_y 9 -da_grid_z 9 -ksp_monitor -ksp_rtol 1e-5 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 9 -da_grid_y 9 -da_grid_z 9 -ksp_monitor -ksp_rtol 1e-10 2>&1 | tee -a "$LOGFILE"

srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 17 -da_grid_y 17 -da_grid_z 17 -ksp_monitor -ksp_rtol 1e-1 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 17 -da_grid_y 17 -da_grid_z 17 -ksp_monitor -ksp_rtol 1e-5 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 17 -da_grid_y 17 -da_grid_z 17 -ksp_monitor -ksp_rtol 1e-10 2>&1 | tee -a "$LOGFILE"

srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 33 -da_grid_y 33 -da_grid_z 33 -ksp_monitor -ksp_rtol 1e-1 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 33 -da_grid_y 33 -da_grid_z 33 -ksp_monitor -ksp_rtol 1e-5 2>&1 | tee -a "$LOGFILE"
srun -n 1 --hint=nomultithread ps2-3D -da_grid_x 33 -da_grid_y 33 -da_grid_z 33 -ksp_monitor -ksp_rtol 1e-10 2>&1 | tee -a "$LOGFILE"


