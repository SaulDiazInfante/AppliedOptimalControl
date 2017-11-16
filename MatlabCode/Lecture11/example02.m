clear
N = 16;
xx = -1.01:.005:1.01; 
clf
s = 'Chebyshev points'; 
x = cos(pi*(0:N)/N);
u = 1./(1+16*x.^2);
uu = 1./(1+16*xx.^2);
p = polyfit(x,u,N);
% interpolation
pp = polyval(p,xx);
% evaluation of interpolant
hold on
plot(xx,uu,'g.','markersize',8)
plot(x,u,'r.','markersize',13)
line(xx,pp,'linewidth',.8)
legend('f(\cdot)','f(x_{j})', 'Chebyshev')
axis([-1.1 1.1 -1 1.5]), title(s)
error = norm(uu-pp,inf);
text(-.5,-.5,['max error = ' num2str(error)])
