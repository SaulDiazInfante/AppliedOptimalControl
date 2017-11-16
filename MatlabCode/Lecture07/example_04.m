clear;
clc;
f = @(x,y) x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;
g = @(x,y) x.*y/2+(x+2).^2+(y-2).^2/2-2;
ezplot(g,[-6,0,-1,7])
hold on
ezcontour(f,[-6,0,-1,7])
plot(-.9727,.4685,'ro');
legend('constraint','f contours','minimum');
x0 = [-2 1];
options = optimoptions('fmincon', 'Algorithm', 'interior-point',...
    'Display',...
    'iter');
%
fun = @(x) f(x(1),x(2));
gfun = @(x) deal(g(x(1),x(2)),[]);
[x,fval,exitflag,output] = fmincon(fun,x0,[],[],[],[],[],[],gfun,options);
plot(x(1),x(2),'bx')