function [c, ceq] = nlconst(x)
c1 = x(1)^4 - 5 * sinh(x(2) / 5);
c2 = x(2)^2 - 5 * tanh(x(1) / 5) - 1.0;
c = [c1, c2];
ceq =[];
