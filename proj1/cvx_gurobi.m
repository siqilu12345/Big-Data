function x=cvx_gurobi(A,b)
[m,n]=size(A);
cvx_begin quiet
    cvx_solver gurobi
    variable x(n);
    minimize( norm(x,1) );
    subject to
        A*x==b;
cvx_end