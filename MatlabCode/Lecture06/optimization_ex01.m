syms x1 x2 real
x = [x1;x2]; % column vector of symbolic variables
f = log(1 + 3*(x2 - (x1^3 - x1))^2 + (x1 - 4/3)^2);

ezsurfc(f,[-2 2])
view(127,38)
gradf = jacobian(f,x).'
hessf = jacobian(gradf,x);
%fh = matlabFunction(f,gradf,hessf,'vars',{x});
fh = matlabFunction(f,'vars',{x});
options = optimoptions(...
    'fminunc',...
    'Display',...
    'final',...
    'Algorithm',...
    'quasi-newton');

[xfinal,fval,exitflag,output2] = fminunc(fh,[-1;2],options)
