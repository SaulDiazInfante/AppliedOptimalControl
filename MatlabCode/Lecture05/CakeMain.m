clear; clc;
T=70;
b=0.9;
x0=1;
h=0.1;
x=0.1:h:x0;
t=0:T;
hold on

axis equal
for i=0:T
    hi=optPolicy(i,T,b,x);
    plot(x,hi)
    axis([0 1 0 1])
    % drawnow;
    % pause(0.3)
    M(i+1) = getframe;
end
hold of
figure()
movie(M,5)
v = VideoWriter('videoPolicies.avi');
open(v);
writeVideo(v, M);
close(v);