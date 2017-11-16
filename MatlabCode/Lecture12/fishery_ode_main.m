close all
clear
global r K;
r = 2/100; %  grow rate
K = 1000; %load medium capacity
h = .01;
T = 200;
tspan =  0 : h : T;
x_zero = 250;
options = odeset('RelTol', .0000001, 'AbsTol' ,.000000001);
[t, x_k] = ode45(@fishery_ode, tspan, x_zero, options);
hold off;
%
%
x_restriction = 750 * ones(length(t),1);
x_final = x_k(end);
x_final_level = x_final * ones(length(t),1);
hold on
plot(t,x_k,'-k')
plot(t, x_final_level,':');
plot(t, x_restriction,'r--');
%
%
%
%
x_zero = 40;
options = odeset('RelTol', .0000001, 'AbsTol' ,.000000001);
[t, x_k] = ode45(@fishery_ode, tspan, x_zero, options);
x_final = x_k(end);
x_final_level = x_final * ones(length(t),1);
plot(t,x_k,'r')
plot(t, x_final_level,'r:');