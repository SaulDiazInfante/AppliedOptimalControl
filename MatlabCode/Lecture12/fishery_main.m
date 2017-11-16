% create grid
clear grd
grd.Nx{1} = 201;
grd.Xn{1}.lo = 0;
grd.Xn{1}.hi = 1000;
grd.Nu{1} = 21;
grd.Un{1}.lo = 0;
grd.Un{1}.hi = 10;
% set initial state
grd.X0{1} = 250;
% set final state constraints
grd.XN{1}.hi = 1000;
grd.XN{1}.lo = 750;
% define problem
clear prb
prb.Ts = 1/5;
prb.N = 200*1/prb.Ts + 1;

% set options
options = dpm();
options.BoundaryMethod = 'Line'; % also possible: 'none' or 'LevelSet';
if strcmp(options.BoundaryMethod,'Line')
    options.FixedGrid = 1;
    options.Iter = 10;
    options.Tol = 1e-8;
end
N = prb.N
t = prb.Ts * (0:N);
[res, dyn] = dpm(@fishery,[],grd,prb,options);
hold on
yyaxis left
plot(t, res.X{1}, 'b')
yyaxis right
plot(t(2:end), res.U{1}, 'ro')

%plot(t(2:end), res.C{1})
legend('X','U','C','I')
offset = 5;
Ax = [t; res.X{1}];
Au = [t(2:end); res.U{1}];
Ac = [t(2:end); res.C{1}];
fileID = fopen('OptimalPath.dat','w');
fprintf(fileID,'%6s %12s\n','t','x_t');
% fprintf(fileID,'%6.2f %12.8f\n',Ax(1 : offset : end, :));
fprintf(fileID,'%6.2f %12.8f\n', Ax);
fclose(fileID);

fileID = fopen('OptimalPolicy.dat','w');
fprintf(fileID,'%6s %12s\n','t','u_t');
%fprintf(fileID,'%6.2f %12.8f\n',Au(1 : offset : end, :));
fprintf(fileID,'%6.2f %12.8f\n', Au);
fclose(fileID);

fileID = fopen('OptimalCost.dat','w');
fprintf(fileID,'%6s %12s\n','t','c_t');
%fprintf(fileID,'%6.2f %12.8f\n', Ac(1 : offset : end, :));
fprintf(fileID,'%6.2f %12.8f\n', Ac);
fclose(fileID);

