function A=build_laplace_2D(N)

n=N^2;
e = ones(n,1);

% first put the '1' diagonals into A
A = spdiags([e e], [-N N], n, n);

% make a block matrix T
e = ones(N,1);
T = spdiags([e -4*e e], -1:1, N, N);

% put the T blocks into A
for k=1:N
    A(1+(k-1)*N:k*N,1+(k-1)*N:k*N)=T;
end
h = 1/(1+N);
A = A/h^2;
