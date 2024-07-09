function [V,D] = QREig(A, k)
% Usage: [V,D] = QREig(A, k) produces an orthogonal matrix V and
% a diagonal matrix D so that A = V*D*V’ and V’*V = EYE(SIZE(V)).
% Columns of V are eigenvectors and diagonal entries of D are
% eigenvalues.
% The input A is a square matrix
% The input k is the number of steps
% your code

[n, n] = size(A);

[P, H] = myHess(A);
[V, D] = QRWithoutShifts(H, k);

end