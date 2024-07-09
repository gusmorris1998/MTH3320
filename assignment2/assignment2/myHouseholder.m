function [Q, R]=myHouseholder(A)

[m, n]=size(A);
R=A;
Q_t = zeros(m);

for k=1:n
    x = R(k:m,k);
    y = zeros(m-k+1,1);

    if x(1) < 0
        y(1) = norm(x);
    else
        y(1) = -norm(x);
    end

    v = x - y;
    u_k = v/norm(v);

    R(k:m,k:n) = R(k:m,k:n) - 2*u_k*(transpose(R(k:m,k:n)));
    Q_t(k:m,1:m) = Q_t(k:m,1:m) - 2*u_k*(transpose(Q_t(k:m,1:m)));
end

Q = transpose(Q_t);




