#!/bin/bash

LOGFILE="HW2_results_ex5.txt"

# Delete the log file if it exists
rm -f "$LOGFILE"

# Ex5 Part 1
echo -e "\n\n############# Ex5 Part 1 ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D -da_grid_x 1024 -da_grid_y 1024 -ksp_view 2>&1 | tee -a "$LOGFILE"

# Ex5 Part 3
echo -e "\n\n############# Ex5 Part 3 ###############\n\n" | tee -a "$LOGFILE"

# GMRES without PC (different restart values)
for RESTART in 30 15 60 200; do
    echo -e "\n\n############# GMRES without PC ${RESTART} vectors ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type none -ksp_gmres_restart $RESTART \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done

# GMRES with Jacobi and ILU (different restart values)
for RESTART in 30 15 60 200; do
    echo -e "\n\n############# GMRES with Jacobi and ILU ${RESTART} vectors ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type bjacobi -sub_pc_type ilu -ksp_gmres_restart $RESTART \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done

# CG without PC at different refinement levels
for REFINEMENT in 0 2 4 6; do
    echo -e "\n\n############# CG without PC Part 4 ${REFINEMENT} refine ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-2D \
    -da_refine $REFINEMENT -ksp_type cg -pc_type none \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done

# CG with Jacobi at different refinement levels
for REFINEMENT in 0 2 4 6; do
    echo -e "\n\n############# CG with Jacobi Part 4 ${REFINEMENT} refine ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-2D \
    -da_refine $REFINEMENT -ksp_type cg -pc_type bjacobi -sub_pc_type icc \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done

# Direct Solvers with LU and Cholesky
echo -e "\n\n############# LU as direct solver/PC ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 1 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type preonly -pc_type lu \
    -pc_factor_mat_solver_type petsc \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"


for ORDERING in nd rcm; do
    echo -e "\n\n############# Cholesky with ${ORDERING} ordering ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 1 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 -ksp_type preonly -pc_type cholesky \
    -pc_factor_mat_solver_type petsc -mat_ordering_type $ORDERING \
    -pc_factor_shift_type POSITIVE_DEFINITE \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done

# PCMAMG with varying levels
for LEVELS in 2 4 12; do
    echo -e "\n\n############# PCMAMG ${LEVELS} levels ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type cg -pc_type gamg -pc_gamg_levels $LEVELS \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done


# Three different solvers/preconditioners on 3 levels
echo -e "\n\n############# 3 preconditioners on 3 levels ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type cg -pc_type gamg -pc_gamg_levels 3 \
    -mg_levels_0_ksp_type preonly -mg_levels_0_pc_type lu \
    -mg_levels_1_ksp_type gmres -mg_levels_1_pc_type ilu \
    -mg_levels_2_ksp_type richardson -mg_levels_2_pc_type sor \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor

# W-cycle multigrid
echo -e "\n\n############# W-cycle multigrid ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type gamg -pc_gamg_levels 4 \
    -mg_levels_cycle_type w \
    -mg_levels_ksp_type gmres -mg_levels_pc_type jacobi \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor

# MG type additive
echo -e "\n\n############# MG type additive ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type gamg -pc_gamg_levels 4 \
    -pc_mg_type additive \
    -mg_levels_ksp_type gmres -mg_levels_pc_type jacobi \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor

# MG type full
echo -e "\n\n############# MG type full ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type gamg -pc_gamg_levels 4 \
    -pc_mg_type full \
    -mg_levels_ksp_type gmres -mg_levels_pc_type jacobi \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor

# Galerkin Process
echo -e "\n\n############# MG Galerkin Process ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type gamg -pc_gamg_levels 3 \
    -pc_gamg_coarse_eq_limit 1000 \
    -mg_levels_ksp_type gmres -mg_levels_pc_type jacobi \
    -pc_gamg_type agg \
    -pc_gamg_agg_nsmooths 1 \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor

# Hypre BoomerAMG
echo -e "\n\n############# Hypre BoomerAMG ###############\n\n" | tee -a "$LOGFILE"
mpiexec -n 8 ./ps2-2D \
    -da_grid_x 1024 -da_grid_y 1024 \
    -ksp_type gmres -pc_type hypre -pc_hypre_type boomeramg \
    -ksp_rtol 1e-5 -ksp_converged_reason -log_view -ksp_monitor


# CG, Block-Jacobi, ICC
for REFINEMENT in 1 2 3; do
    echo -e "\n\n############# Part 5 b) CG, Block-Jacobi, ICC refine ${REFINEMENT} ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-3D \
    -da_refine $REFINEMENT -ksp_type cg -pc_type bjacobi \
    -sub_pc_type icc -ksp_rtol 1e-5 \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done



# Hypre BoomerAMG at different refinement levels
for REFINEMENT in 1 2 3; do
    echo -e "\n\n############# Part 5 b) BoomerAMG refine ${REFINEMENT} ###############\n\n" | tee -a "$LOGFILE"
    mpiexec -n 8 ./ps2-3D \
    -da_refine $REFINEMENT -ksp_type cg -pc_type hypre \
    -pc_hypre_type boomeramg -ksp_rtol 1e-5 \
    -ksp_converged_reason -log_view -ksp_monitor 2>&1 | tee -a "$LOGFILE"
done