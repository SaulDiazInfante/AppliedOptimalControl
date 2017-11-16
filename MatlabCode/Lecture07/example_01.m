clc;
clear;
g = @(x) polyval([1, -10.5, 39, -59.5, 30], x);
f = @(x) polyval([1, -8, 22, -24, 1], x);
xvet = 0: 0.05: 4;
plot(xvet , f(xvet));
%[x, fval] = fminunc(g, 5)
