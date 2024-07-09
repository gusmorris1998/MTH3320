clc

disp('**********')

maxit=500;
tol=1e-15;

% consider a small problem with the 2D Laplacian matrix
N=4;
n=N^2;
A=build_laplace_2D_kron(N);

% generate a test problem with a random solution vector x_exact, and compute the
% corresponding right-hand side b
x_exact=rand(n,1);
b=A*x_exact;

% initial guess for the iterative methods
x0=zeros(n,1);

% call the steepest descent and conjugate gradient solvers
[x_cg rescg stepscg]=conjGrad(A,x0,b,tol,maxit);
[x_steepest ressteepest stepssteepest]=steepest(A,x0,b,tol,maxit);

x_cg = x_cg(:,end);
x_steepest = x_steepest(:,end);

display('error for steepest descent, # of steps')
err=norm(x_exact-x_steepest)
stepssteepest=stepssteepest

disp('----')

display('error for conjugate gradients, # of steps')
err=norm(x_exact-x_cg)
stepscg=stepscg
