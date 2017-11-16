function ht=optPolicy(t,T,b,x)
    ht=(b^t/recurrenceAt(t,T,b))*x;