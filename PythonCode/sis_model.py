import numpy as np
import scipy as sci
from nonstandar_sir import SirDiscreteModel


class SisDiscreteModel:
    """

    """

    def __init__(self, beta, gamma, k=6, p=2, r=2, T_0=0, T=5, N_H=1000):
        # model parameters
        self.gamma = gamma
        self.beta = beta
        self.s_zero = 1.0
        self.i_zero = 0.0
        self.N_H = N_H
        self.k = k
        self.p = p
        self.r = r
        self.T0 = T_0
        self.N = 10 ** k
        self.P = 10 ** p
        self.R = 10 ** r
        #
        self.T = T
        # self.N = 2 ** k
        # self.P = 2 ** p
        # self.R = 2 ** r
        #
        self.dt = self.T / np.float(self.N)
        self.IndexN = np.arange(self.N + 1)
        # set of index to Ito integral
        self.tau = self.IndexN[0:self.N + 1:self.P]
        self.t = np.linspace(0, self.T, self.N + 1)
        #
        self.Dt = np.float(self.R) * self.dt
        self.L = self.N / self.R
        self.sis = np.zeros([self.N + 1, 2])

    def initialize_mesh(self, k, p, r, T0, T):
        """
            Set stensil parameters
        """
        # Stensil of the mesh
        # self.k = k
        # self.p = p
        # self.r = r
        self.T0 = T0
        self.N = 10 ** k
        self.P = 10 ** p
        self.R = 10 ** r
        self.T = T
        #
        self.dt = self.T / np.float(self.N)
        self.IndexN = np.arange(self.N + 1)
        self.tau = self.IndexN[0:self.N + 1:self.P]
        self.t = np.linspace(0, self.T, self.N + 1)
        #
        self.Dt = np.float(self.R) * self.dt
        self.L = self.N / self.R

    def set_parameters(self, beta, gamma, s_0):
        """
            Set parameters of SIR model
        """
        self.s_zero = s_0
        self.i_zero = 1.0 - self.s_zero
        self.gamma = gamma
        self.beta = beta

    def a(self, y, t0):
        """
            The rhs of SIR model
        """
        s = y[0]
        i = y[1]
        beta = self.beta
        gamma = self.gamma

        s_ = -beta * s * i + gamma * i
        i_ = beta * s * i - gamma * i
        return np.array([s_, i_])

    def compute_r0(self):
        beta = self.beta
        gamma = self.gamma
        r_0 = beta / gamma
        print "R0: ", r_0
        return r_0


class SisNumerics(SisDiscreteModel):
    #
    #
    def lsoda_solution(self):
        y0 = [self.s_zero, self.i_zero]
        t = self.t
        sol = sci.integrate.odeint(self.a, y0, t)
        self.sis = sol
        return sol

    def linear_steklov(self):
        beta = self.beta
        gamma = self.gamma
        N = self.N
        h = self.Dt
        sis = np.zeros([N + 1, 2])
        sis[0] = [self.s_zero, self.i_zero]
        #
        for j in np.arange(N):
            s_j = sis[j, 0]
            i_j = sis[j, 1]
            a_i_j = beta * s_j - gamma
            a_s_j = -beta * i_j
            b_sj = gamma * i_j
            li_jp1 = np.log(np.exp(h * a_i_j)) + np.log(i_j)

            ls_jp1 = np.log(np.exp(h * a_s_j) * s_j \
                    + b_sj * ((np.exp(h * a_s_j) - 1.0) / a_s_j))

            sis[j + 1] = np.array([np.exp(ls_jp1), np.exp(li_jp1)])
        self.sis = sis
        return sis

    def euler(self):
        beta = self.beta
        gamma = self.gamma
        N = self.N
        h = self.Dt
        sis = np.zeros([N + 1, 2])
        sis[0] = [self.s_zero, self.i_zero]
        #
        for j in np.arange(N):
            sis_p1 = sis[j] + h * self.a(sis[j], 0)
            sis[j+1] = sis[j] + h * self.a(sis_p1, 0)
        self.sis = sis
        return sis
