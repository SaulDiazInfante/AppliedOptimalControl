function B_t = recurrenceBt(t, T, beta)
if t==T
    B_t = 0.0;
    return
end
B_T = 0.0;
for i = T-1:-1:t
    A_tp1 =recurrenceAt(i+1, T, beta);
    A_t = recurrenceAt(i, T, beta);
    term1 = beta ^ i * log(beta ^ i / A_t);
    term2 = A_tp1 * log(A_tp1 / A_t); 
    B_t = term1 + term2 + B_T;
    B_T = B_t;
end
    