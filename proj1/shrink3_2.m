function x=shrink3_2(L,y,s,miu)
l=size(s);
n=l(1);
z=L*y+1/miu*s*eye(n)-1/miu*s*s*y;
x=zeros(n,n);
for i=1:n
    for j=1:n
        if z(i,j)>1
            x(i,j)=(z(i,j)-1)/L;
        elseif z(i,j)<-1
            x(i,j)=(z(i,j)+1)/L;
        end
    end
end
