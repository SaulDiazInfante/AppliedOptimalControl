x = (datetime(2016,1,1):hours(4):datetime(2016,1,2))';
x.Format = 'MMM dd, HH:mm';
T = [31 25 24 41 43 33 31]';
WeatherData = table(x,T,'VariableNames',{'Time','Temperature'})
plot(WeatherData.Time, WeatherData.Temperature, 'o')
xq = (datetime(2016,1,1):minutes(1):datetime(2016,1,2))';
V = interp1(WeatherData.Time, WeatherData.Temperature, xq, 'spline');
hold on
plot(xq,V,'r')
writetable(WeatherData,'table.dat','Delimiter',' ')  