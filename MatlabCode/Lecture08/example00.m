clear;
clc
[X,Y] = meshgrid(-2:.01:3);
Z = (5*sinh(Y./5) >= X.^4); 
% Z=1 where the first constraint is satisfied, Z=0 otherwise
Z = Z + 2*(5*tanh(X./5) >= Y.^2 - 1); 
% Z=2 where the second is satisfied, Z=3 where both are
surf(X,Y,Z,'LineStyle','none');
fig = gcf;
fig.Color = 'w'; % white background
view(0,90)
hold on
plot3(1.333,1.037, 4,'*','MarkerEdgeColor','r','MarkerSize',8);
plot3(.4396, .0373, 4,'o','MarkerEdgeColor','r','MarkerSize',8); 
% best point
xlabel('x')
ylabel('y')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimoptions('fmincon', ...
            'Algorithm', ...
            'interior-point', ...
            'Display', ...
            'final');    
%plot3(xfinal(1), xfinal(2), 4,'p','MarkerEdgeColor','b','MarkerSize',12); 
hold off