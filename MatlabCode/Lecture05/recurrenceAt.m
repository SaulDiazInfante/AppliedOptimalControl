function At=recurrenceAt(t,T,b)
    if t==T
        At=b^T;
        return;
    end
    At=0;
    AT=b^T;
    for i=T-1:-1:t
        At=b^i+AT;
        AT=At;
    end
    