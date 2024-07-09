function [x res steps]=conjGrad(A,x0,b,tol,maxit)
% Performs a sequence of conjugate gradient iterations
% on A x = b using the initial estimate u0, until the 2-norm
% of the residual is smaller than tol (relative
% to the initial residual), or until the number of iterations
% reaches maxit. ‘steps’ is the number of steps
% that were performed, and ‘res’ is a vector with the
% residual size after every interation (the 2-norm of
% the residual vector).

steps = 0;
r_k = b - A*x0;
res = [norm(b - A*x0)];
p_k = r_k;
x = [x0];

while res(end) > tol && steps < maxit
    steps = steps + 1;
    alpha = (r_k.'*r_k)/((r_k.')*A*p_k);
    x_k = x(:, end) + alpha*p_k;
    x = [x, x_k];
    r_k_1 = r_k;
    r_k = r_k_1 - alpha*A*p_k;
    beta = (r_k.'*r_k)/(r_k_1.'*r_k_1);
    p_k = r_k + beta*p_k;
    res = [res; norm(r_k)];
end

x = x(:,end);

end

    

