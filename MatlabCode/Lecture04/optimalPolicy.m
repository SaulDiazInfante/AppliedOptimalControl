function h_t = optimalPolicy(t, T, x, beta)
%
%
%
% optimal policy
%
%
%    
    sum = 0.0;
    for i=0 : 1 : T - t
        sum = sum + beta^i;
    end
    %A_t = recurrenceAt(t, T, beta);
    %h_t = (beta ^ (T - t) / A_t) * x;
    h_t = x / sum;