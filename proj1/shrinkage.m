function x=shrinkage(A,y,b,L)
z=L*y-A'*(A*y-b);
x=zeros(length(z),1);
for i=1:length(z)
    if z(i)>1
        x(i)=(z(i)-1)./L;
    elseif z(i)<1
        x(i)=(z(i)+1)./L;
    end
end