static char help[] = "Solves a 1D Poisson problem with DMDA and KSP.\n\n";

#include <petsc.h>
#include <petscviewer.h>
#include <math.h>

extern PetscErrorCode formMatrix(DM, Mat);
extern PetscErrorCode formExactAndRHS(DM, Vec, Vec);

int main(int argc,char **args) {
    DM             da;
    Mat            A;
    Vec            b,u,uexact;
    KSP            ksp;
    PetscReal      errnorm;
    DMDALocalInfo  info;
    PetscViewer    viewer;
    PetscBool      writeMatrix = PETSC_FALSE;

    PetscCall(PetscInitialize(&argc,&args,NULL,help));

    // Check if -matrix option is passed to write the matrix to a file
    PetscCall(PetscOptionsGetBool(NULL, NULL, "-matrix", &writeMatrix, NULL));

    // change default 9 size using -da_grid_x M
    PetscCall(DMDACreate1d(PETSC_COMM_WORLD,DM_BOUNDARY_NONE,9,1,1,NULL,&da));

    // create linear system matrix A
    PetscCall(DMSetFromOptions(da));
    PetscCall(DMSetUp(da));
    // PetscCall(DMDASetUniformCoordinates(da,0.0,1.0,-1.0,-1.0,-1.0,-1.0));
    PetscCall(DMCreateMatrix(da,&A));
    // PetscCall(MatSetOptionsPrefix(A,"a_"));
    PetscCall(MatSetFromOptions(A));

    // create RHS b, approx solution u, exact solution uexact
    PetscCall(DMCreateGlobalVector(da,&b));
    PetscCall(VecDuplicate(b,&u));
    PetscCall(VecDuplicate(b,&uexact));

    // fill vectors and assemble linear system
    //PetscCall(formExact(da,uexact));
    PetscCall(formExactAndRHS(da,uexact,b));
    //PetscCall(formRHS(da,b));
    PetscCall(formMatrix(da,A));

    // Save matrix A to file if writeMatrix is true
    if (writeMatrix) {
        PetscCall(PetscViewerASCIIOpen(PETSC_COMM_WORLD, "matrix_1D.mtx", &viewer));
        PetscCall(PetscViewerSetFormat(viewer, PETSC_VIEWER_ASCII_MATRIXMARKET));
        PetscCall(MatView(A, viewer));  // write matrix to file
        PetscCall(PetscViewerDestroy(&viewer));
    }

    // create and solve the linear system
    PetscCall(KSPCreate(PETSC_COMM_WORLD,&ksp));
    PetscCall(KSPSetOperators(ksp,A,A));
    PetscCall(KSPSetFromOptions(ksp));
    PetscCall(KSPSolve(ksp,b,u));

    // report on grid and numerical error
    PetscCall(VecAXPY(u,-1.0,uexact));    // u <- u + (-1.0) uxact
    PetscCall(VecNorm(u,NORM_INFINITY,&errnorm));
    PetscCall(DMDAGetLocalInfo(da,&info));
    PetscCall(PetscPrintf(PETSC_COMM_WORLD,
                "on %d point grid:  error |u-uexact|_inf = %g\n",
                info.mx,errnorm));
    
    PetscCall(VecNorm(u,NORM_1,&errnorm));
    PetscCall(DMDAGetLocalInfo(da,&info));
    PetscCall(PetscPrintf(PETSC_COMM_WORLD,
                "on %d point grid:  error |u-uexact|_1 = %g\n",
                info.mx,errnorm));

    PetscCall(VecNorm(u,NORM_2,&errnorm));
    PetscCall(DMDAGetLocalInfo(da,&info));
    PetscCall(PetscPrintf(PETSC_COMM_WORLD,
                "on %d point grid:  error |u-uexact|_2 = %g\n",
                info.mx,errnorm));

    PetscCall(VecDestroy(&u));
    PetscCall(VecDestroy(&uexact));
    PetscCall(VecDestroy(&b));
    PetscCall(MatDestroy(&A));
    PetscCall(KSPDestroy(&ksp));
    PetscCall(DMDestroy(&da));
    PetscCall(PetscFinalize());

    PetscCall(PetscFinalize());
    return 0;
}
//ENDMAIN

//STARTMATRIX
PetscErrorCode formMatrix(DM da, Mat A) {
    DMDALocalInfo  info;
    PetscInt       i;

    PetscCall(DMDAGetLocalInfo(da,&info));
    for (i=info.xs; i<info.xs+info.xm; i++) {
        PetscReal   v[3];
        PetscInt    row = i, col[3];
        PetscInt    ncols=0;
        if ( (i==0) || (i==info.mx-1) ) {
            col[ncols] = i;  v[ncols++] = 1.0;
        } else {
            col[ncols] = i;  v[ncols++] = 2.0;
            if (i-1>=0) {
                col[ncols] = i-1;  v[ncols++] = -1.0;
            }
            if (i+1<=info.mx-1) {
                col[ncols] = i+1;  v[ncols++] = -1.0;
            }
        }
        PetscCall(MatSetValues(A,1,&row,ncols,col,v,INSERT_VALUES));
    }
    PetscCall(MatAssemblyBegin(A,MAT_FINAL_ASSEMBLY));
    PetscCall(MatAssemblyEnd(A,MAT_FINAL_ASSEMBLY));
    return 0;
}
//ENDMATRIX

//STARTEXACT
PetscErrorCode formExactAndRHS(DM da, Vec uexact, Vec b) {
  DMDALocalInfo  info;
  PetscInt       i;
  PetscReal      h, x, *ab, *auexact;

  PetscCall(DMDAGetLocalInfo(da,&info));
  h = 1.0/(info.mx-1);
  PetscCall(DMDAVecGetArray(da, b, &ab));
  PetscCall(DMDAVecGetArray(da, uexact, &auexact));
  for (i=info.xs; i<info.xs+info.xm; i++) {
    x = i * h;
    auexact[i] = 3*x + sin(20*x);
    if ( (i>0) && (i<info.mx-1) )
      ab[i] = h*h * 400*sin(20*x);
    else
      ab[i] = 3*x + sin(20*x);
  }
  PetscCall(DMDAVecRestoreArray(da, uexact, &auexact));
  PetscCall(DMDAVecRestoreArray(da, b, &ab));
  PetscCall(VecAssemblyBegin(b));
  PetscCall(VecAssemblyEnd(b));
  PetscCall(VecAssemblyBegin(uexact));
  PetscCall(VecAssemblyEnd(uexact));
  return 0;
}
//ENDEXACT
