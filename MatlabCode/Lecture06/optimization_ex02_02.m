clear;
clc;
syms x1 x2 real;
x = [x1;x2];
c1 = x1^4 - 5*sinh(x2/5);
c2 = x2^2 - 5*tanh(x1/5) - 1;
c = [c1 c2];

f = log(1 + 3*(x2 - (x1^3 - x1))^2 + (x1 - 4/3)^2);

ezsurfc(f,[-2 2])
view(127,38)



gradc = jacobian(c,x).'; % transpose to put in correct form
%
constraint = matlabFunction(c,[],[],'vars',{x});
gradf = jacobian(f,x).'; % column gradf
hessf = jacobian(gradf,x);

hessc1 = jacobian(gradc(:,1),x); % constraint = first c column
hessc2 = jacobian(gradc(:,2),x);

hessfh = matlabFunction(hessf,'vars',{x});
hessc1h = matlabFunction(hessc1,'vars',{x});
hessc2h = matlabFunction(hessc2,'vars',{x});

myhess = @(x,lambda)(hessfh(x) + ...
    lambda.ineqnonlin(1)*hessc1h(x) + ...
    lambda.ineqnonlin(2)*hessc2h(x));

options = optimoptions('fmincon', ...
    'Algorithm','interior-point', ...
    'Display','final');
%'GradObj','on', ...
    %'Hessian','on', ...
    %'Hessian', 'user-supplied', ...
    %'HessFcn', myhess, ...
    
% fh2 = objective without Hessian
fh2 = matlabFunction(f,'vars',{x});
[xfinal,fval,exitflag,output] = fmincon(fh2,[-1;2],...
    [],[],[],[],[],[],constraint,options)