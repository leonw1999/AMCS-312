import numpy as np
import matplotlib.pyplot as plt
from scipy.io import mmread

# Load the matrix from the .mtx file
matrix = mmread("matrix_1D.mtx")

# If the matrix is sparse, convert it to a dense array
if hasattr(matrix, 'toarray'):
    matrix = matrix.toarray()

# Check the shape of the matrix
print(f"Matrix shape: {matrix.shape}")

# Check if the matrix is 2D
if matrix.ndim != 2:
    raise ValueError("The matrix is not 2D.")

# Create the contour plot
plt.figure(figsize=(8, 6))
plt.contourf(matrix, 20, cmap='viridis')  # 20 levels of contours, use your preferred colormap
plt.colorbar()  # Add color bar to indicate scale
plt.title('Contour plot of matrix A in 1D')
plt.xlabel('Column Index')
plt.ylabel('Row Index')

output_pdf = 'contour_plot1D.pdf'  # Output file name
plt.savefig(output_pdf, format='pdf')

plt.show()

# Load the matrix from the .mtx file
matrix = mmread("matrix_2D.mtx")

# If the matrix is sparse, convert it to a dense array
if hasattr(matrix, 'toarray'):
    matrix = matrix.toarray()

# Check the shape of the matrix
print(f"Matrix shape: {matrix.shape}")

# Check if the matrix is 2D
if matrix.ndim != 2:
    raise ValueError("The matrix is not 2D.")

# Create the contour plot
plt.figure(figsize=(8, 6))
plt.contourf(matrix, 20, cmap='viridis')  # 20 levels of contours, use your preferred colormap
plt.colorbar()  # Add color bar to indicate scale
plt.title('Contour plot of matrix A in 2D')
plt.xlabel('Column Index')
plt.ylabel('Row Index')

output_pdf = 'contour_plot2D.pdf'  # Output file name
plt.savefig(output_pdf, format='pdf')

plt.show()

# Load the matrix from the .mtx file
matrix = mmread("matrix_3D.mtx")

# If the matrix is sparse, convert it to a dense array
if hasattr(matrix, 'toarray'):
    matrix = matrix.toarray()

# Check the shape of the matrix
print(f"Matrix shape: {matrix.shape}")

# Check if the matrix is 2D
if matrix.ndim != 2:
    raise ValueError("The matrix is not 2D.")

# Create the contour plot
plt.figure(figsize=(8, 6))
plt.contourf(matrix, 20, cmap='viridis')  # 20 levels of contours, use your preferred colormap
plt.colorbar()  # Add color bar to indicate scale
plt.title('Contour plot of matrix A in 3D')
plt.xlabel('Column Index')
plt.ylabel('Row Index')

output_pdf = 'contour_plot3D.pdf'  # Output file name
plt.savefig(output_pdf, format='pdf')

plt.show()
