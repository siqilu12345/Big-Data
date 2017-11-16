function x=solve3_2
maxiter=10000;
n=30;
sigma=10;
s=zeros(n,n);
for i=1:n
    for j=1:n
        s(i,j)=0.6.^abs(i-j);
    end
end
%{
for i=1:n
    for j=1:n
        if i>j
            s(i,j)=0.5*binornd(1,0.1);
            s(j,i)=s(i,j);
        end
    end
end
l=eig(s);
lmax=max(l);
lmin=min(l);
delta=(lmax-n*lmin)./(n-1);
s=(s+delta.*eye(n))./delta;
%}
I=eye(n);
x0=I;
x=x0;
lambda=10*n;
miu=10000;
z=I;
A=z*s;
for i=1:maxiter
    z=(s*s)^(-1)*(s*A-miu*x*s+miu*I);
    he=sum(sum(z.*z));
    if he>lambda^2
        for u=0:1:100*n
            z=(s*s+2*miu*u*I)^(-1)*(s*A-miu*s*x+miu*I);
            he=sum(sum(z.*z));
            if he<lambda^2
                break
            end
        end
    end
    A=z*s+miu*x;
    for j=1:n
        for k=1:n
            if A(j,k)>1
                A(j,k)=1;
            elseif A(j,k)<-1
                A(j,k)=-1;
            end
        end
    end
    he=sum(sum(z.*z));
    lambda=he.^0.5;
    x=x+1/miu*(z*s-A);
    if max(max(abs(z*s-A)))<=10^(-8)
        break
    end
end
x=-sigma*lambda+trace(z);