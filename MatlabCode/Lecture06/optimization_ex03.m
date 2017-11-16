syms x1 x2 real
x = [x1;x2]; % column vector of symbolic variables
f = exp(x1) * (4 * x1^2 + 2 * x2 ^ 2 + 4 * x1 * x2 + 2 * x2 + 1)
ezsurfc(f,[-2 .5 -2 2])
view(45,45)

options = optimoptions(@fminunc,'Algorithm','quasi-newton');
x0 = [-1,1]; % Starting guess
[x,fval,exitflag,output] = fminunc(@objfun, x0, options);