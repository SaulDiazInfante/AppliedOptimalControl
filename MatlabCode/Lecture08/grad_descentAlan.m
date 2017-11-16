
function [xopt,fopt,niter,gnorm,dx]=grad_descentAlan(varargin)
if nargin==0
    x0=[3 3]';
elseif nargin==1
    x0=varargin{1};
else
    error('Incorrect number of input arguments.')
end
 
tol=1e-6;
maxiter=1000;
dxmin=1e-6;
alpha=0.1;
gnorm=inf; x=x0 ; niter=0; dx=inf;
 
f=@(x1,x2) x1.^2+x1.*x2 +3*x2.^2;
%xopt=0;
%fopt=0;
 
figure(1); clf;
ezcontour(f,[-5 5 -5 5]); axis equal; hold on
 
f2=@(x) f(x(1),x(2));
 
while and(gnorm>=tol, and(niter<=maxiter,dx>=dxmin))
   g=grad(x);
   gnorm=norm(g);
   xnew=x - alpha*g;
   if ~isfinite(xnew)
       display(['Number of iterations:  ' num2str(niter)])
       error('x is inf or NaN')
   end    
   
   plot([x(1) xnew(1)], [x(2) xnew(2)], 'ko-')
   refresh
   niter =niter + 1;
   dx = norm(xnew-x);
   x= xnew;
end    
   
xopt=x;
fopt=f2(xopt);
niter=niter-1;
 
 
function g=grad(x)
   g=[2*x(1)+x(2) 
       x(1)+6*x(2)];