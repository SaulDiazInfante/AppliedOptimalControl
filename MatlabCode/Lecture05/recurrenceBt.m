function Bt=recurrenceBt(t,T,b)
    if t==T
        Bt = 0;
        return
    end
    Bt=0;
    BT=0;
    for i=T-1:-1:t
        Atp1 = recurrenceAt(i+1,T,b);
        At = recurrenceAt(i,T,b);
        fAtAtp1 = b^i * log(b ^i / At) + Atp1 * log(Atp1 / At);
        Bt=fAtAtp1 + BT;
        BT=Bt;
    end
    