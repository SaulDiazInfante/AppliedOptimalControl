function J_t = optimalValueFunction(t, T, x, beta)
%
%
%
%Return the value function to the cake problem
%
%
%
J_t = recurrenceAt(t, T, beta) * log (x) + recurrenceBt(t, T, beta);
