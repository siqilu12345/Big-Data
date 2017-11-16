function r=shrink3_1(s,x,z,rou,miu)
y=x+miu*(x^(-1)+z*s);
a=size(y);
n=a(1);
r=zeros(n,n);
for i=1:n
    for j=1:n
        if y(i,j)>miu*rou
            r(i,j)=(y(i,j)-miu*rou);
        elseif z(i,j)<-miu*rou
            r(i,j)=(y(i,j)+miu*rou);
        end
    end
end
