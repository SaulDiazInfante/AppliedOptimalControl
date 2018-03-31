import numpy as np
import matplotlib.pyplot as plt
from nonstandar_sir import NumericsSirModel

s_0 = 820
i_0 = 110
r_0 = 70
n_H = s_0 + i_0 + r_0  # lambda / mu
mu = 0.25
lambda_ = mu * n_H
beta = 0.002
gamma = 0.56
ns_sir = NumericsSirModel(lambda_, beta, mu, gamma, N_H=n_H, k=7, p=2, r=2,
                 T0=0, T=30)

x_zero = np.array([s_0, i_0, r_0])
ns_sir.set_parameters(lambda_, beta, gamma, mu, x_zero)
sol = ns_sir.mickens()
s = sol[:, 0]
i = sol[:, 1]
r = sol[:, 2]
t_h = ns_sir.Dt * np.arange(ns_sir.L+1)
fig, (ax1, ax2, ax3) = plt.subplots(nrows=3, ncols=1)
#
r_0 = ns_sir.compute_r0()
ax1.plot(t_h, s, 'o')
ax1.set_ylabel("suceptibles")
#
ax2.plot(t_h, i, 's')
ax2.set_ylabel("infected")
#
ax3.plot(t_h, r, '*')
ax3.set_ylabel("recover")
#
plt.tight_layout()
plt.figure()
plt.plot(t_h, s, '-o', label='suceptibles')
plt.plot(t_h, i, '-s', label='infected')
plt.plot(t_h, r, '-*', label='recovered')
# plt.plot(t_h, n_H - (s+i), '+', label='cl')
plt.legend(loc=0)
plt.show()
