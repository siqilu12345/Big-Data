function s=admms(A,lambda,miu,x)
s=A'*lambda+miu*x;
for i=1:length(s)
    if s(i)>1
        s(i)=1;
    elseif s(i)<-1
        s(i)=-1;
    end
end
