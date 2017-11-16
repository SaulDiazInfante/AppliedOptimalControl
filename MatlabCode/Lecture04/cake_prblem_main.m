%
%
%    The cake problem
%
%
clear
T = 10;
t = 1:T;
beta = 0.96;
x_0 = 1;
%
Xc_t = zeros(T,1);
X_t = zeros(T,1);
J_t = zeros(T,1);
Jpi_t = zeros(T,1);
Xc_t(1) = x_0 - optimalPolicy(0, T, x_0, beta);
X_t(1) = 0.9 * x_0;
J_t(1) = valueFunction(0, T, x_0, beta);
Jpi_t(1) = valueFunction(0, T, x_0, beta);
for i = 1 : T-1
    X_t(i+1) = 0.9 * X_t(i);
    Xc_t(i+1) = Xc_t(i) - optimalPolicy(i, T, Xc_t(i), beta);
    J_t(i) = valueFunction(i, T, Xc_t(i), beta);
    Jpi_t(i) = valueFunction(i, T, X_t(i), beta);
end
hold on
plot([0,t] ,[x_0, Xc_t'],'r-o')
plot([0,t] ,[x_0, X_t'],'k-*')
figure
hold on
plot(t, J_t, 'r-o')
plot(t, Jpi_t, 'k-*')

