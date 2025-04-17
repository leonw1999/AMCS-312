import numpy as np

laplace = np.diag(np.full(7, 2)) - np.diag(np.ones(6), 1) - np.diag(np.ones(6), -1)

c = np.ones((7,1))
r = np.array([-3, -2, -1, 0, 1, 2 ,3]).reshape((7, 1))
p = np.array([9, 4, 1, 0, 1, 4, 9]).reshape((7, 1))
s = np.array([-1, -1, -1, 0, 1, 1, 1]).reshape(7, 1)
o = np.array([-1, 1, -1, 1, -1, 1, -1]).reshape((7, 1))

print(laplace @ c)
print(laplace @ r)
print(laplace @ p)
print(laplace @ s)
print(laplace @ o)

print(np.linalg.inv(laplace) @ c)