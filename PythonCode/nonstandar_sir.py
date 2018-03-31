import timeit
import numpy as np
from scipy.optimize import fsolve


class SirDiscreteModel:
    """
        Set the parameters for the SIR Model.
        Reference: Optimal strategy of vaccination & treatment in an
        SIR epidemic model.
    """
    
    def __init__(self, lambda_, beta, mu, gamma, N_H,
                 k, p, r, T_0, T):
        self.x_zero = np.array([99.0, 1.0, 0.0])
        self.mu = mu
        self.gamma = gamma
        self.beta = beta
        self.lambda_ = lambda_
        self.N_H = N_H
        self.k = k
        self.p = p
        self.r = r
        self.T0 = T_0
        # self.N = 10 ** k
        # self.P = 10 ** p
        # self.R = 10 ** r
        self.T = T
        self.N = 2 ** k
        self.P = 2 ** p
        self.R = 2 ** r
        #
        self.dt = self.T / np.float(self.N)
        self.IndexN = np.arange(self.N + 1)
        # set of index to Ito integral
        self.tau = self.IndexN[0:self.N + 1:self.P]
        self.t = np.linspace(0, self.T, self.N + 1)
        #
        self.Dt = np.float(self.R) * self.dt
        self.L = self.N / self.R
    
    def initialize_mesh(self, k, p, r, T0, T):
        """
            Set setencil parameters
        """
        # Stensil of the mesh
        self.k = k
        self.p = p
        self.r = r
        self.T0 = T0
        # self.N=10.0**k
        # self.P=10.0**p
        # self.R=10.0**r
        self.N = 2.0 ** k
        self.P = 2.0 ** p
        self.R = 2.0 ** r
        self.T = T
        #
        self.dt = self.T / np.float(self.N)
        self.IndexN = np.arange(self.N + 1)
        # set of index to Ito integral
        self.tau = self.IndexN[0:self.N + 1:self.P]
        self.t = np.linspace(0, self.T, self.N + 1)
        #
        self.Dt = np.float(self.R) * self.dt
        self.L = self.N / self.R
    
    def set_parameters(self, lambda_, beta, gamma, mu, x_zero):
        """
            Set parameters of SIR model
        """
        self.x_zero = x_zero
        self.mu = mu
        self.gamma = gamma
        self.beta = beta
        self.lambda_ = lambda_
    
    def a(self, s, i, r):
        """
            The rhs of SIR model
        """
        lambda_ = self.lambda_
        beta = self.beta
        gamma = self.gamma
        mu = self.mu
        
        s_ = lambda_ - beta * s * i - mu * s
        i_ = beta * s * i - (mu + gamma) * i
        r_ = gamma * i - mu * r
        return np.array([s_, i_, r_])
    
    def compute_r0(self):
        lambda_ = self.lambda_
        beta = self.beta * self.N_H
        gamma = self.gamma
        mu = self.mu
        r_0 = beta / (mu + gamma)
        print "R0: ", r_0
        return r_0


class NumericsSirModel(SirDiscreteModel):
    """
        Numerics for the SIR with demographic
    """
    
    def __init__(self, lambda_, beta, mu, gamma, N_H, k, p, r, T0, T):
        SirDiscreteModel.__init__(self, lambda_, beta,
                                  mu, gamma, N_H, k, p, r, T0, T)
        self.x_ssls = np.zeros([self.L + 1, 3])
        self.x_mck = np.zeros([self.L + 1, 3])
    
    #
    def fgh_mck_functions(self, s_, i_, r_):
        """
            :param s_: suceptible 
            :param i_: infected
            :param r_: recover
        """
        lambda_ = self.lambda_
        beta = self.beta
        gamma = self.gamma
        mu = self.mu
        h = self.Dt
        phi_mu_h = (np.exp(mu * h) - 1.0) / mu
        #
        num_f = s_ + lambda_ * phi_mu_h
        den_f = (1.0 + mu * phi_mu_h) + beta * phi_mu_h * i_
        f_mck = num_f / den_f
        #
        num_g = (1.0 + beta * phi_mu_h * f_mck) * i_
        den_g = 1.0 + phi_mu_h * (mu + gamma)
        g_mck = num_g / den_g
        #
        num_h = r_ + gamma * phi_mu_h * g_mck
        den_h = 1.0 + mu * phi_mu_h
        h_mck = num_h / den_h
        return np.array([f_mck, g_mck, h_mck])
    
    def mickens(self):
        
        L = self.L
        
        self.x_mck[0] = self.x_zero
        for j in np.arange(L):
            self.x_mck[j + 1] = self.fgh_mck_functions(self.x_mck[j][0],
                                                       self.x_mck[j][1],
                                                       self.x_mck[j][2])
        x_mck = self.x_mck
        return x_mck
