%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% step 1: generate the matrix A, initial vector x, and shift value mu
%
% if you have difficulties in using these (may due to the random number generator)
% download the file matrix_data_A4.mat and use the A, x, and mu 
%

n = 100; % size of the matrix

% generate random eigenvectors
[Q, ~] =  qr(randn(n), 0);

% generate eigenvalues and sort
lambda = sort(linspace(0, 50, n), 'descend');

% create the matrix
A = Q * diag(lambda) * Q';

% initial vector
w = Q(:,2:end)*(rand(n-1,1)-0.5);
x = Q(:,1)*lambda(1) + w*lambda(1)*0.05;
x = x/norm(x);

% shift for the inverse iteration
mu = lambda(1) - (lambda(1) - lambda(2)) * 0.3;


% load the existing date set
% load('matrix_data_Q4.mat')

% number of iterations in the test
k = 10;

%--------------------------------------------------------------------------
% Step 2:
%

%----------------
%
% APPLY THE RAYLEIGH QUOTIENT ITERATION, CALL YOUR FUNCTION HERE
% 

[B, lamb]=RayleighIteration(A, x, k);

%
% you need use your outputs and modify the following lines accordingly
% to compute the error in eigenvalue and eigenvector estimates

% Flip each column of B before computing the error
for i = 1:size(B,2)
    B(:,i) = flip_vec(B(:,i), Q(:,1));
end

% compute the error in eigenvectors and name the error err_b
err_b = sqrt(sum( abs(B - repmat(Q(:,1), 1, k)).^2, 1));

% compute the error in eigenvalues and name the error err_l
err_l = abs(lamb - lambda(1));

%----------------


%--------------------------------------------------------------------------
% Step 3
%
%----------------
%
% APPLY THE INVERSE ITERATION, CALL IT HERE

[B_inv, lamb_inv] = InverseIteration(A, mu, x, k);

%
% modify the code in Step 2 to compute the error in eigenvectors and name 
% the error err_b_inv

% Flip each column of B before computing the error

for i = 1:size(B_inv,2)
    B_inv(:,i) = flip_vec(B_inv(:,i), Q(:,1));
end

%

err_b_inv = sqrt(sum( abs(B_inv - repmat(Q(:,1), 1, k)).^2, 1));

% modify the code in step 2 to compute the error in eigenvaluess and name
% the error err_l_inv

err_l_inv = abs(lamb_inv - lambda(1));


%--------------------------------------------------------------------------
% Step 4
%
% plot the errors 
figure('position', [100, 100, 800, 800])

% eigenvalues
subplot(2,2,1)
plot(lambda, 'o-')
xlabel('Index')
ylabel('$|\lambda_i$|', 'Interpreter','latex')
title('Eigenvalues')
axis tight

% error in eigenvector estimates
subplot(2,2,3)
semilogy(1:k, err_b, 'o-')
hold on
semilogy(1:k, err_b_inv, 'x-')
xlabel('Iteration')
ylabel('$\|b^{(k)} - v_1\|$', 'Interpreter','latex')
title('Eigenvector convergence')
legend('Rayleigh quotient iteration', 'inverse iteration')
axis tight

% error in eigenvalue estimates
subplot(2,2,4)
semilogy(1:k, err_l, 'o-')
hold on
semilogy(1:k, err_l_inv, 'x-')
xlabel('Iteration')
ylabel('$\|\lambda^{(k)} - \lambda_1\|$', 'Interpreter','latex')
title('Eigenvalue convergence')
legend('Rayleigh quotient iteration', 'inverse iteration')
axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
