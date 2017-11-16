function x=bregman3_2
maxiter=1000;
n=30;
sigma=0.1;
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
y=x0;
t=1;
L=sum(sum((s*s).^2))^0.5;
miu=1;
for i=1:maxiter
    newx=shrink3_2(L,y,s,miu);
    if max(max(abs(newx-x)))<10^(-8)
        break
    end
    newt=(1+(1+4*t^2)^0.5)/2;
    y=newx+(t-1)/newt.*(newx-x);
end
x=newx;
x=sum(sum(abs(x)));