function xnew = fishery_ode(~, xold)
    global r  K;
    xnew = r * xold * (1.0 - xold/K);