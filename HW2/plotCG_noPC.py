import matplotlib.pyplot as plt
import re

def extract_data(file_path):
    iterations, residuals = [], []
    with open(file_path, 'r') as file:
        for line in file:
            match = re.match(r"\s*(\d+) KSP Residual norm ([\deE.-]+)", line)
            if match:
                iterations.append(int(match.group(1)))
                residuals.append(float(match.group(2)))
    return iterations, residuals

# Extract data from both files
iterations1, residuals1 = extract_data('Untitled.rtf')
iterations2, residuals2 = extract_data('Untitled2.rtf')

# Plotting the data
plt.figure(figsize=(8, 6))
plt.plot(iterations1, residuals1, marker='o', markersize=2, label='Untitled.rtf')
plt.plot(iterations2, residuals2, marker='s', markersize=2, label='Untitled2.rtf')

plt.yscale('log')  # Log scale for residual norms
plt.xlabel('Iteration Count')
plt.ylabel('Residual Norm')
plt.title('KSP Residual Norm vs Iteration Count')
plt.grid(True, which="both", linestyle='--', linewidth=0.5)
plt.legend(['CG without PC', 'CG with Jacobi PC'])
plt.savefig("CGplot.pdf", format='pdf')
plt.show()


