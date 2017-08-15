function dydt = seir(t, y, a, b, d, c, e, g)
% t:  time
% y: solution [S,E,I,R,N]
% S0, E0, R0, R0: initial conditions
% b: birth rate
% d: death rate
% c: probability of incidence
% e: rate at which the exposed individuals become infectious
% g: rate at which infectious individuals recover
% a: death rate due to the disease
    S0 = y(1);
    E0 = y(2);
    I0 = y(3);
    R0 = y(4);
    N0 = y(5);
    S = b * N0 - d * S0 - c * S0 * I0;
    E = c * S0 * I0 - (e + d) * E0;
    I = e * E0 - ( g + a + d) * I0;
    R = g * I0 - d * R0 ;
    N = (b - d) * N0 - a * I0;
    dydt = [S E I R N]';
