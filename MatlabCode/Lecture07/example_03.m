f = @(x,y) x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;
ezsurfc(f,[-2,2])

fun = @(x) f(x(1),x(2));
x0 = [-.5; 0];
options = optimoptions('fminunc','Algorithm','quasi-newton');
options.Display = 'iter';
[x, fval, exitflag, output] = fminunc(fun,x0,options);
hold on
scatter3(x(1),x(2), fval,35,...
    'MarkerEdgeColor','k',...
     'MarkerFaceColor',[1 0 0])