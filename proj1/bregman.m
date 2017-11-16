function x=bregman(A,b,x0)
maxiter=10000;
[m,n]=size(A);
L=abs(eigs(A'*A,1));
t=1;
y=x0;
x=x0;
for i=1:maxiter
    newx=shrinkage(A,y,b,L);
    newt=(1+(1+4*t.^2).^0.5)./2;
    y=newx+(t-1)./newt.*(newx-x);
    if max(abs(newx-x))<=10^(-8)
        break
    end
    x=newx;
    t=newt;
end
