clc;
clear;
g = @(x) polyval([1, -10.5, 39, -59.5, 30], x);
xvet = 1: 0.05: 4;
plot(xvet , g(xvet));
[x, fval] = fminunc(g, 2)
