import numpy as np
import matplotlib.pyplot as plt

plt.rcParams.update({'font.size': 11})
plt.rcParams['lines.linewidth'] = 1.05

a = np.linspace(0, 1, 11)
p = 2 ** np.arange(11)

M = np.zeros((11,11))

for i in range(11):
    for j in range(11):
        M[i, j] = 1 / (a[j] + (1 - a[j])/p[i])

print(a)
print(p)
print(M)

plt.figure()
plt.title('Number of processors: {}'.format(p[5]))
plt.plot(a, M[5, :], 'r*--')
plt.xlabel(r'Non-parallelizable fraction of code')
plt.ylabel('Speedup')
plt.savefig("Repositories/AMCS-312/HW1/latex/FixProc.pdf", format="pdf", bbox_inches="tight")
plt.show()

plt.figure()
plt.title('Fraction of non-parallelizable code: {}'.format(a[5]))
plt.semilogx(p, M[:, 5], 'b*--')
plt.xlabel(r'Number of processors')
plt.ylabel('Speedup')
plt.savefig("Repositories/AMCS-312/HW1/latex/FixFrac.pdf", format="pdf", bbox_inches="tight")
plt.show()