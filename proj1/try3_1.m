function x=try3_1
maxiter=100000;
n=30;
rou=0.1;
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
x0=eye(n);
x=x0;
for i=1:maxiter
    deltax=s+rou*sign(x)-x^(-1);
    if max(max(abs(deltax)))<=10^(-8)
        break
    end
    x=x-1.618*deltax;
end