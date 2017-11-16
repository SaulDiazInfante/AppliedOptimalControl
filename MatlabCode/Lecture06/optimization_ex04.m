clc
clear all
close all
x=1:100;
mp=20;
yt=mp*x;
m=0:2:2*mp;
epochs=length(m);
for k=1:epochs
    y=m(k)*x;
    e=yt-y;
    E(k)=e*e';
end

temp=m(randperm(length(m)));
w=m(2);
eta=1e-6;
for i=1:epochs
    for j=1:length(x)
    y(j)=w*x(j);
    e(j)=yt(j)-y(j);
    end
    J(i)=e*e'; 

    scatter(m,E,'.')
    hold on
    plot(m,E)

    [v,p]=min(abs(E));

    scatter(mp,0,'y','filled')
    scatter(w,J(i),'g','filled');
    k(i)=2*e*x';
    if(w+eta*e*x'>w-eta*e*x')
        a=w+eta*e*x';
        b=w-eta*e*x';
    else
        a=w-eta*e*x';
        b=w+eta*e*x';
    end
        
    plot(a:-1:b,k(i)*(w-(a:-1:b))+J(i),'r','linewidth',2)

    if(i==1)
    title('Adaptation of ''w'' to minimize J(w) using steepest decent (LMS)')
    xlabel('adaptive parameter : w')
    ylabel('Cost Function : J(w)');
    grid minor 
    end
    pause(2/i)
    w=w+eta*e*x';
    y=w*x;
end
