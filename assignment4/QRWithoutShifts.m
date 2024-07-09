function [Q,T] = QRWithoutShifts(H, k)
% Usage: [Q,T] = QRWithoutShifts(H, k) produces an orthogonal matrix
% Q and an upper triangular matrix T so that H = Q*T*Q’ and
% Q’*Q = EYE(SIZE(Q)). The QR algorithm without shifts is used.
% The input H is a Hessenberg matrix that is produced in Step 1.
% The input k is the number of steps.

[m,n] = size(H);
Q = eye(n);
A = H;

for i=1:k
    [U, R] = qr(A);
    A = R*U;
    Q = Q*U;
end

T = A;