figure
syms x1 x2 real
x = [x1;x2]; % column vector of symbolic variables
f = log(1 + 3*(x2 - (x1^3 - x1))^2 + (x1 - 4/3)^2);

ezsurfc(f,[-2 2])
view(127,38)
%
W = log(1 + 3*(Y - (X.^3 - X)).^2 + (X - 4/3).^2); 
% W = the objective function
W(Z < 3) = nan; % plot only where the constraints are satisfied
surf(X,Y,W,'LineStyle','none');
view(68,20)
%view(127,38)
hold on
plot3(.4396, .0373, .8152,'o','MarkerEdgeColor','r', ...
    'MarkerSize',8); % best point
xlabel('x')
ylabel('y')
zlabel('z')
hold off
%
figure
syms x1 x2 real
x = [x1;x2]; % column vector of symbolic variables
f = log(1 + 3*(x2 - (x1^3 - x1))^2 + (x1 - 4/3)^2);

ezsurfc(f,[-2 2])
view(68,20)
%view(127,38)