%model parameters
b = 0.525; d = 0.5; c = 0.01; e = 0.5; g = 0.1; a = 0.2;
A = 0.1;
T = 20;
%initial conditions
S0 = 1000; E0 = 100; I0 = 50; R0 = 15; N0 = S0 + E0 + I0+ R0;
y0 = [S0 E0 I0 R0 N0]'; 
%
% Controled solution
sol_with_control = seir_controled(b,d,c,e,g,a,S0,E0,I0,R0,A,T);
%
% Uncontroled solution
tspan=[0 20];
[t,y] = ode45(@(t,y) seir(t, y, a, b, d, c, e, g ), tspan, y0);

fig = figure;
%
%
ax1 = subplot(2,1,1);
plot(ax1, sol_with_control(1,:), sol_with_control(4,:), '-o')
hold on
plot(ax1,t,y(:, 3),'--')
legend('controled','uncontroled')
ylabel('Infected Population')
%
ax2 = subplot(2,1,2);
plot(ax2, sol_with_control(1,:), sol_with_control(6,:), '-o')
hold on
plot(ax2, t,y(:, 5),'--')
legend('controled','uncontroled')
ylabel('Whole Population')
print(fig,'seir_controled','-dpng')