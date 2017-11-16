function test
n = 1024;
m = 512;

A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;


x0 = rand(n,1);

errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
resfun = @(x) norm(A*x-b);
nrm1fun = @(x) norm(x,1);
tic; 
x1=cvx_gurobi(A,b);
t1 = toc;

tic; 
x2 = direct_gurobi(A,b);
t2 = toc;

tic;
x3= bregman(A,b,x0);
t3=toc;

tic;
x4= ADMM(A,b,x0);
t4=toc;
% print comparison results with cvx-call-mosek
fprintf('cvx:        nrm1: %3.2e, res: %3.2e cpu: %5.2f\n', resfun(x1), nrm1fun(x1),t1);
fprintf('call-gurobi: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-gurobi: %3.2e\n', ...
        resfun(x2), nrm1fun(x2), t2, errfun(x1, x2));
fprintf('methodbregman: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-gurobi: %3.2e\n', ...
        resfun(x3), nrm1fun(x3), t3, errfun(x1, x3));
fprintf('methodADMM: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-gurobi: %3.2e\n', ...
        resfun(x4), nrm1fun(x4), t4, errfun(x1, x4));