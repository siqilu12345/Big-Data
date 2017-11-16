function x=testr
n=30;
rou=1;
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
cvx_begin quiet
    variable z(n,n) symmetric;
    maximize log_det(z);
    subject to
       norm(z-s,Inf)<=rou;
cvx_end
x=cvx_optval;