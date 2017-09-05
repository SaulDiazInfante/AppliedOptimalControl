clear
T=55;
t=1:1:T;
r = 0.02;
p_0 = 0.0;
c_0 = 0.0;
x_0 = 0.0;
fraction_consume=0.45;
x_t = zeros(T,1);
xrisk_t = zeros(T,1);
x_1 = worker_earn(t(1),r,p_0,c_0,x_0);
xrisk_1 = worker_earn_risk(t(1),r,p_0,c_0,x_0);
x_t(1) = x_1;
xrisk_t(1) = xrisk_1;
p_t = .5;
for i=1:T-1
  c_t = fraction_consume * x_t(i);
  crisk_t = fraction_consume * xrisk_t(i);
  x_t(i+1) = worker_earn(t(i+1),r,p_t,c_t,x_t(i));
  xrisk_t(i+1) = worker_earn_risk(t(i+1),r,p_t,crisk_t,xrisk_t(i));
end  
hold on
%uncoment for matlab-- note patchline is free function given in this path
%patchline(t, xrisk_t,'linestyle','-','edgecolor','k','linewidth',1,...
%    'edgealpha',0.1)
%coment next line for matlab
plot(xrisk_t,'k.')
plot(x_t,'r-')
xlabel({'time','(in periods)'})
ylabel('Asset (standard Currency)')
