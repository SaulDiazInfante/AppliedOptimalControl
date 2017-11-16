clear
N = 16;
xx = -1.01:.005:1.01; 
clf;
s = 'equispaced points'; 
x = -1 + 2 * (0:N) / N; 
u = 1 ./ ( 1 + 16 * x .^ 2);
uu = 1 ./ ( 1 + 16 * xx .^ 2);
p = polyfit(x,u,N);  % interpolation
pp = polyval(p,xx);
% evaluation of interpolant
hold on
plot(xx,uu,'g.','markersize',8)
plot(x,u,'r.','markersize',13)
line(xx,pp,'linewidth',.8)
axis([-1.1 1.1 -1 1.5]), 
legend('f(\cdot)','f(x_{j})', 'polyfit')
title(s)
error = norm(uu-pp,inf);
text(-.5,-.5,['error = ' num2str(error)])
