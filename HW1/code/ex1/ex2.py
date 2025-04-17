import numpy as np
import matplotlib.pyplot as plt

list = []
err = 1
n = 1

while err > 0.1:
    Q = 3*n / (3 + 4*n + 2)
    err = (0.75 - Q)/0.75
    list.append(Q)
    n += 1

print(list)