clc

m=100;
n=15;

t=(0:m-1)'/(m-1);
A=[];
for i=1:n
    A = [A t.^(i-1)];
end

[Q,R]=myGramSchmidt(A);
[Qm,Rm]=myGramSchmidtMod(A);
[Qmatl,Rmatl]=qr(A);


norm(Q'*Q-eye(n))
norm(A-Q*R)

norm(Qmatl'*Qmatl-eye(m))
norm(A-Qmatl*Rmatl)
