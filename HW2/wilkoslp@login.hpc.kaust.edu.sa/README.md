---
title: solving poisson equation on uniform grid
epoch: 1741689825
date:  2025-03-11T13-43-45
---

The code solves a linear algebraic system arising from the discretization of
Poisson’s Equation, a second-order Partial Differential Equations (PDE) based on
the Laplacian operator, on a structured grid.

It is based upon the Portable, Extensible Toolkit for Scientific Computation
(PETSc) framework (see http://www.mcs.anl.gov/petsc).

```sh
export PETSC_DIR=/path/to/local/petsc/installation
export PETSC_ARCH=<petsc-installation-default-arch>

# compile and run the 2D version (default)
make ps2
./ps2

# compile and run the 1D version
make ps1-1D
./ps1-1D
```

