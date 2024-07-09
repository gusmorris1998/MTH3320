clc

disp('**********')

maxit=500;
tol=0;

% generate a test problem with a random solution vector x_exact, and compute the
% corresponding right-hand side b

cond_A = []
iterations_cg = [];
iterations_steepest = [];

% initial guess for the iterative methods

for N=[16, 32, 64]
    n=N^2;
    x0=zeros(n,1);
    x_exact=rand(n,1);
    A=build_laplace_2D_kron(N);
    b = 2*ones(N^2, 1);

    cond_A = [cond_A; cond(full(A))]

    [x_cg rescg stepscg]=conjGrad(A,x0,b,tol,maxit);
    [x_steepest ressteepest stepssteepest]=steepest(A,x0,b,tol,maxit);

    for i=2:size(rescg)
        diff = abs(rescg(i-1)-rescg(i))
        if diff < 1e-4
            break
        end
    end

    iterations_cg = [iterations_cg; i];

    for i=2:size(rescg)
        diff = abs(ressteepest(i-1)-ressteepest(i))
        if diff < 1e-4
            break
        end
    end

    iterations_steepest = [iterations_steepest; i];

        
end