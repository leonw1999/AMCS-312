#!/bin/bash

LOGFILE="HW2_results_ex4.txt"

# Delete the log file if it exists
rm -f "$LOGFILE"

# Ex4 a)
echo -e "\n\n############# Ex4 a) 1D ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4a -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4a -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4a -da_refine 3 | tee -a "$LOGFILE"

echo -e "\n\n############# Ex4 a) 2D###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4a -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4a -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4a -da_refine 3 | tee -a "$LOGFILE"

echo -e "\n\n############# Ex4 a) 3D###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4a -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4a -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4a -da_refine 3 | tee -a "$LOGFILE"
# Ex4 b)
echo -e "\n\n############# Ex4 b) 1D ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4b -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4b -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-1D_ex4b -da_refine 3 | tee -a "$LOGFILE"

echo -e "\n\n############# Ex4 b) 2D###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4b -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4b -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D_ex4b -da_refine 3 | tee -a "$LOGFILE"

echo -e "\n\n############# Ex4 b) 3D###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4b -da_refine 1 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4b -da_refine 2 | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-3D_ex4b -da_refine 3 | tee -a "$LOGFILE"