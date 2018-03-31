import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint


def sir_allen(S, I, R, u_k):
    """

    :type I: float
    """
    S_ = S * (1.0 - beta * h * I - u_k)
    I_ = I * (1.0 - gamma * h + beta * h * S)
    R_ = R + gamma * h * I + u_k * S
    return np.array([S_, I_, R_])


def sir_nsds(S, I, R, u_k):
    gamma_u = gamma + u_k
    S_ = S / (beta * varphi * I + 1.0)
    I_ = ((1.0 + varphi * beta * S_) / (1.0 + varphi * gamma_u)) * I
    R_ = R + varphi * gamma_u * I_
    return np.array([S_, I_, R_])


# article parameters
N = 100
alpha = 3.0
beta = alpha / N
h = 0.25
gamma = 1.0
varphi = (1.0 - np.exp(- gamma * h)) / gamma

# t_T = 20
n_T = 21
S_0 = 99
I_0 = 1
R_0 = 0
#
S_i = S_0
I_i = I_0
R_i = R_0
#
sir_solution = np.zeros([n_T, 3])
sir_solution_uncontroled = np.zeros([n_T, 3])
sir_nsfd = np.zeros([n_T, 3])
#
sir_solution[0] = [S_0, I_0, R_0]
sir_solution_uncontroled[0] = [S_0, I_0, R_0]
sir_nsfd[0] = [S_0, I_0, R_0]
#
erre_0 = (S_0 * alpha) / (N * gamma)
condition = np.max([gamma * h, alpha * h])
print "R0: ", erre_0
print "condition: ", condition

for i in np.arange(n_T - 1):
    u_k = 0.0 * np.random.rand()
    sir_solution[i + 1] = sir_allen(sir_solution[i][0],
                                    sir_solution[i][1],
                                    sir_solution[i][2],
                                    u_k
                                    )
    sir_solution_uncontroled[i + 1] = sir_allen(sir_solution_uncontroled[i][0],
                                                sir_solution_uncontroled[i][1],
                                                sir_solution_uncontroled[i][2],
                                                0
                                                )
    sir_nsfd[i+1] = sir_nsds(sir_nsfd[i][0], sir_nsfd[i][1], sir_nsfd[i][2], 0)

t = np.arange(n_T)
# plt.plot(t, sir_solution[:, 1], '--*')
plt.plot(t, sir_solution_uncontroled[:, 1], '--o')
plt.plot(t, sir_nsfd[:, 1], '--+')
plt.show()
