import numpy as np
import matplotlib.pyplot as plt
from sis_model import SisNumerics

beta = 2.0
gamma = 0.1
i_0 = 0.01
s_0 = 1.0 - 0.01
sis = SisNumerics(beta, gamma)
sis.set_parameters(beta, gamma, s_0)
sol = sis.lsoda_solution()
sol_stk = sis.linear_steklov()
sol_euler = sis.euler()
t = sis.t
plt.plot(t, sol[:, 1], '-')
plt.plot(t, sol_stk[:, 1], '-')
plt.plot(t, sol_euler[:, 1], '-')
# plt.axis([0, 5, 0, 1])
plt.show()
