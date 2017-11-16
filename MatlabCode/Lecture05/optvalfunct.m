function Jt=optvalfunct(t,T,b,x)
    Jt=recurrenceAt(t,T,b)*log(x) +recurrenceBt(t,T,b);
    