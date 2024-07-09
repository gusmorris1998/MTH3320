N = 30;
maxit = 400;
tol = 1e-6;
A = build_laplace_2D(N);
b = 2*ones(N^2, 1);

% initial guess for the iterative methods
x0=zeros(N^2,1);

[x_cg rescg stepscg]=conjGrad(A,x0,b,tol,maxit);
[x_steepest ressteepest stepssteepest]=steepest(A,x0,b,tol,maxit);

t_cg = 0:1:stepscg
t_st = 0:1:stepssteepest

figure(1);
plot(t_cg,rescg, t_st,ressteepest)

log_rescg = log10(rescg)
log_ressteepest = log10(ressteepest)

figure(2);
plot(t_cg,log_rescg)

figure(3);
plot(t_st, log_ressteepest)

n = size(ressteepest);
m = size(rescg);

