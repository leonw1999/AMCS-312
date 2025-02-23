import numpy as np
import matplotlib.pyplot as plt

list = []
err = 100
n = 1

while err > 0.1:
    Q = 9*n / (3 + 4*n + 2)
    err = (2.25 - Q)/2.25
    list.append(Q)
    n += 1

print(list)