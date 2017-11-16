function x=ADMM(A,b,x0)
miu=100;
maxiter=1000;
[m,n]=size(A);
s=zeros(n,1);
lambda=zeros(n,1);
x=x0;
for i=1:maxiter
    lambda=(A*A')\(-miu.*(A*x-b)+A*s);
    s=admms(A,lambda,miu,x);
    z=(A'*lambda-s)./miu;
    if max(abs(z))<=10^(-10)
        break
    end
    x=x+z;
end
