function x=solve3_1
maxiter=10000;
n=30;
rou=0.1;
s=zeros(n,n);
miu=10;
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
x0=eye(n);
x=x0;
z=x0;
for i=1:maxiter
    x=shrink3_1(s,x,z,rou,miu);
    A=s*x-miu*(z+eye(n));
    z=z+(s*x-A)/miu;
end
x=log(det(x))-trace(s*x)-rou*sum(sum(abs(x)));