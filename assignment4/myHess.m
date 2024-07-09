function [P,H] = myHess(A)
% Usage: [P,H] = myHess(A) produces a unitary matrix P and a
% Hessenberg matrix H so that A = P*H*P’ and P’*P = EYE(SIZE(P)).
% Householder reflections will be used.

[m,n] = size(A);
Pt = eye(n);
H = A;

for k = 1:n-2
    b = H(k+1:n, k);
    v = b + sign(b(1))*norm(b)*eye(n-k,1);
    u = v/norm(v);
  
    Pt(k+1:n, 1:n) = Pt(k+1:n, 1:n) - (2*u)*(u.'*Pt(k+1:n,1:n));

    H(k+1,k) = -sign(b(1))*norm(b);
    H(k+2:n,k) = 0;
    H(k+1:n, k+1:n) = H(k+1:n, k+1:n) - (2*u)*(u.'*H(k+1:n,k+1:n));
    H(1:n, k+1:n) = H(1:n, k+1:n) - (H(1:n, k+1:n)*u)*(2*u).';
end

P = Pt.';