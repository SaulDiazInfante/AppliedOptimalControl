function A_t = recurrenceAt(t, T, beta)
%
%
%    recurrence for the term $A_t$ (cake problem) 
%
%
if T==t
    A_t = beta^T;
    return
end
A_T = beta^T;
for i = T-1:-1:t
    A_t = A_T + beta ^ i;
    A_T = A_t;
end
