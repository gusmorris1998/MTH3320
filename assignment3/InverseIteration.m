function [B, lamb] = InverseIteration(A, mu, x, k)
%
% Usage: [B, lamb] = InverseIteration(A, mu, x, k) carries k steps
% of the inverse iteration for estimating the eigenvalue of A,
% with an initial shift mu, and an initial vector x.
% It generates outputs B and lamb.

% -- B is an (n x k) matrix that stores the estimated eigenvector at
% i-th step as its i-th column, B(:,i)
% -- lamb is a (1 x k) vector that stores the estimated eigenvalue at
% i-th step as its i-th element, lamb(i)
% Note that the initial vector and initial eigenvalue estimate are
% not stored.

n = size(A, 1); % size of the matrix
B = zeros(n, k); % matrix B
lamb = zeros(1, k); % vector lamb

b_i = x;

for i=1:k
    w_i = linsolve(A-mu*eye(n), b_i);
    b_i = w_i/norm(w_i);
    lamb(i) = (b_i)'*(A*b_i);
    B(:,i) = b_i;
end






