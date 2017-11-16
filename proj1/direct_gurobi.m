function x=direct_gurobi(A,b)
[m,n]=size(A);
for i=1:n
    l=['x',num2str(i),'plus'];
    names{i,1}=l;
end
for i=1:n
    l=['x',num2str(i),'minus'];
    names{i+n,1}=l;
end

clear model;
model.A = sparse([A,-A;eye(2*n)]);
model.obj = ones(1,2*n);
model.rhs = [b;zeros(2*n,1)];
model.sense = [repmat('=',m,1);repmat('>',2*n,1)];
model.modelsense = 'min';
model.varnames=names;
clear params;
params.outputflag = 0;
params.resultfile = 'mip1.lp';
result = gurobi(model, params);
x=result.x(1:n)-result.x(n+1:2*n);
%{
disp(result)
for v=1:length(names)
    fprintf('%s %d\n', names{v}, result.x(v));
end

    fprintf('Obj: %e\n', result.objval);
%}
